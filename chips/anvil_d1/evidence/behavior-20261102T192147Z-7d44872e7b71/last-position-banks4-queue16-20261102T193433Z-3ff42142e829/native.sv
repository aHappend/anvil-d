
module tb;
  localparam B=4, SLOTS=7022, WRITES=3617, TOKENS=5;
  reg clk=0;
  always #5 clk=~clk;
  reg rst_n, cancel=0, token_valid=0, new_sequence=0, token_phase=0;
  reg [31:0] token_id=0, token_pos=0;
  wire token_ready, logit_valid, done, error, cancel_done;
  reg logit_ready=0;
  wire [31:0] logit_index;
  wire signed [31:0] logit_data;
  wire [B-1:0] mem_req_valid, mem_req_write, mem_rsp_ready;
  wire [B*4-1:0] mem_req_kind;
  wire [B*3-1:0] mem_req_proj;
  wire [B*32-1:0] mem_req_layer, mem_req_row, mem_req_col, mem_req_wdata;
  wire [B*64-1:0] mem_req_tag;
  reg [B-1:0] mem_req_ready=0, mem_rsp_valid=0, mem_rsp_error=0;
  reg [B*32-1:0] mem_rsp_rdata=0;
  reg [B*64-1:0] mem_rsp_tag=0;
  wire csr_ready, csr_rsp_valid, csr_error;
  wire [31:0] csr_rdata;
  anvil_d1_top #(.NUM_LAYERS(2),.HIDDEN_SIZE(16),.INTERMEDIATE_SIZE(16),.NUM_Q_HEADS(2),.KV_LORA_RANK(3),.QK_NOPE_HEAD_DIM(2),.QK_ROPE_HEAD_DIM(2),.V_HEAD_DIM(2),.ROUTED_EXPERTS(7),.TOP_K(6),.SHARED_EXPERTS(2),.MOE_INTERMEDIATE_SIZE(8),.FIRST_DENSE_LAYERS(1),.VOCAB_SIZE(8),.MAX_SEQ_LEN(5),.BANKS(B),.QUEUE_DEPTH(16),.TILE_K(8),.TILE_ROWS(3)
  ) device (
    .clk(clk),.rst_n(rst_n),.cancel(cancel),
    .token_valid(token_valid),.token_ready(token_ready),
    .token_id(token_id),.token_pos(token_pos),.new_sequence(new_sequence),.token_phase(token_phase),
    .logit_valid(logit_valid),.logit_ready(logit_ready),
    .logit_index(logit_index),.logit_data(logit_data),.done(done),.error(error),.cancel_done(cancel_done),
    .mem_req_valid(mem_req_valid),.mem_req_ready(mem_req_ready),.mem_req_write(mem_req_write),
    .mem_req_kind(mem_req_kind),.mem_req_layer(mem_req_layer),.mem_req_proj(mem_req_proj),
    .mem_req_row(mem_req_row),.mem_req_col(mem_req_col),.mem_req_wdata(mem_req_wdata),
    .mem_req_tag(mem_req_tag),.mem_rsp_valid(mem_rsp_valid),.mem_rsp_error(mem_rsp_error),
    .mem_rsp_ready(mem_rsp_ready),.mem_rsp_rdata(mem_rsp_rdata),.mem_rsp_tag(mem_rsp_tag),
    .csr_valid(1'b0),.csr_write(1'b0),.csr_addr(12'd0),.csr_wdata(32'd0),
    .csr_wstrb(4'd0),.csr_rsp_ready(1'b1),.csr_ready(csr_ready),
    .csr_rsp_valid(csr_rsp_valid),.csr_rdata(csr_rdata),.csr_error(csr_error)
  );
  reg [102:0] keys [0:SLOTS-1];
  reg [31:0] memory [0:SLOTS-1];
  reg initialized [0:SLOTS-1];
  reg [31:0] starts [0:SLOTS-1], counts [0:SLOTS-1];
  integer consumed [0:SLOTS-1];
  reg [31:0] expected [0:WRITES-1], logits [0:TOKENS*8-1];
  reg [B-1:0] pending=0;
  integer delay_cycles [0:B-1];
  reg [B*32-1:0] response_data=0;
  reg [B*64-1:0] response_tag=0;
  reg [200:0] held_request [0:B-1];
  reg [B-1:0] stalled=0;
  reg held_logit=0;
  reg [63:0] previous_logit=0;
  integer cycles=0, writes=0, reads=0, compared_logits=0, completed=0, accepted=0;
  integer request_stalls=0, logit_stalls=0, reset_samples=0;
  integer logit_delay=0;
  reg [63:0] read_bytes=0,write_bytes=0,expert_bytes_observed=0;

  integer b, slot, i, position;
  reg [102:0] key;

  function automatic integer lookup(input [102:0] target);
    integer low, high, middle;
    begin
      low=0; high=SLOTS-1; lookup=-1;
      while (low<=high) begin
        middle=(low+high)/2;
        if (keys[middle]==target) begin lookup=middle; low=high+1; end
        else if (keys[middle]<target) low=middle+1;
        else high=middle-1;
      end
    end
  endfunction

  task automatic check_reset;
    begin
      if ({token_ready,logit_valid,logit_index,logit_data,done,error,cancel_done,
           mem_req_valid,mem_req_write,mem_req_kind,mem_req_layer,mem_req_proj,
           mem_req_row,mem_req_col,mem_req_wdata,mem_req_tag,mem_rsp_ready,
           csr_ready,csr_rsp_valid,csr_rdata,csr_error} !== 0)
        $fatal(1,"RESET_XZ_OR_NONZERO t=%0t",$time);
      reset_samples=reset_samples+1;
    end
  endtask

  initial begin
    rst_n=0;
    $readmemh("checkpoint-images/keys.hex",keys);
    $readmemh("checkpoint-images/memory.hex",memory);
    $readmemh("checkpoint-images/initialized.hex",initialized);
    $readmemh("checkpoint-images/starts.hex",starts);
    $readmemh("checkpoint-images/counts.hex",counts);
    $readmemh("checkpoint-images/expected-writes.hex",expected);
    $readmemh("checkpoint-images/logits.hex",logits);
    for (i=0;i<SLOTS;i=i+1) consumed[i]=0;
    for (i=0;i<B;i=i+1) delay_cycles[i]=0;
`ifdef VERILATOR
    #1;
`else
    #0;
`endif
    check_reset();
    repeat(2) @(negedge clk);
    #1; rst_n=1;
    for (position=0;position<TOKENS;position=position+1) begin
      @(negedge clk);
      case(position%5)
0: token_id=2;
1: token_id=3;
2: token_id=4;
3: token_id=5;
4: token_id=6;
endcase; token_pos=position%5;
      new_sequence=position%5==0; token_phase=position%5!=0; token_valid=1;
      @(posedge clk);
      while (!token_ready) @(posedge clk);
      @(negedge clk); token_valid=0;
      while (completed<=position) @(negedge clk);
    end
    repeat(3) @(negedge clk);
    if (writes!==WRITES || compared_logits!==TOKENS*8 || accepted!==TOKENS ||
        completed!==TOKENS || reads==0 || reset_samples<5 || request_stalls==0 ||
        logit_stalls==0) $fatal(1,"MISSING_COMPARISONS writes=%0d expected=%0d logits=%0d accepted=%0d completed=%0d reads=%0d reset=%0d request_stalls=%0d logit_stalls=%0d",
          writes,WRITES,compared_logits,accepted,completed,reads,reset_samples,request_stalls,logit_stalls);
    for (i=0;i<SLOTS;i=i+1)
      if (consumed[i]!==counts[i]) $fatal(1,"MISSING_WRITE slot=%0d",i);
    $display("SUMMARY cycles=%0d tokens=%0d writes=%0d reads=%0d logits=%0d reset=%0d request_stalls=%0d logit_stalls=%0d",
      cycles,completed,writes,reads,compared_logits,reset_samples,request_stalls,logit_stalls);
    $display("METRICS read_bytes=%0d write_bytes=%0d expert_bytes=%0d",
      read_bytes,write_bytes,expert_bytes_observed);
    $finish;
  end

  always @(negedge clk) begin
    if (!rst_n) check_reset();
    else begin
      for (integer bank=0;bank<B;bank=bank+1)
        mem_req_ready[bank]=!pending[bank] && (cycles+bank)%7!=0;
      if (!logit_valid) begin logit_ready=0; logit_delay=0; end
      else if (logit_delay<4) begin logit_ready=0; logit_delay=logit_delay+1; end
      else logit_ready=1;
    end
  end

  always @(posedge clk) begin
    if (!rst_n) check_reset();
    else begin
      cycles=cycles+1;
      if (cycles>10000000) $fatal(1,"DIAGNOSTIC_CYCLE_BOUND cycles=%0d reads=%0d writes=%0d logits=%0d",
        cycles,reads,writes,compared_logits);
      if ((^{token_ready,logit_valid,done,error,cancel_done,mem_req_valid,mem_rsp_ready,
             csr_ready,csr_rsp_valid,csr_error}) === 1'bx)
        $fatal(1,"ACTIVE_CONTROL_XZ cycle=%0d",cycles);
      if (token_valid && token_ready) accepted=accepted+1;
      for (b=0;b<B;b=b+1) begin
        if (stalled[b] &&
            {mem_req_valid[b],mem_req_write[b],mem_req_kind[b*4+:4],mem_req_layer[b*32+:32],
             mem_req_proj[b*3+:3],mem_req_row[b*32+:32],mem_req_col[b*32+:32],
             mem_req_wdata[b*32+:32],mem_req_tag[b*64+:64]} !== held_request[b])
          $fatal(1,"REQUEST_UNSTABLE bank=%0d cycle=%0d",b,cycles);
        stalled[b]=mem_req_valid[b] && !mem_req_ready[b];
        held_request[b]={mem_req_valid[b],mem_req_write[b],mem_req_kind[b*4+:4],
          mem_req_layer[b*32+:32],mem_req_proj[b*3+:3],mem_req_row[b*32+:32],
          mem_req_col[b*32+:32],mem_req_wdata[b*32+:32],mem_req_tag[b*64+:64]};
        if (stalled[b]) request_stalls=request_stalls+1;
        if (mem_rsp_valid[b] && mem_rsp_ready[b]) begin
          mem_rsp_valid[b]<=0; pending[b]<=0;
        end
        if (pending[b] && !mem_rsp_valid[b]) begin
          if (delay_cycles[b]==0) begin
            mem_rsp_valid[b]<=1;
            mem_rsp_rdata[b*32+:32]<=response_data[b*32+:32];
            mem_rsp_tag[b*64+:64]<=response_tag[b*64+:64];
          end else delay_cycles[b]=delay_cycles[b]-1;
        end
        if (mem_req_valid[b] && mem_req_ready[b]) begin
          if ((^{mem_req_write[b],mem_req_kind[b*4+:4],mem_req_layer[b*32+:32],
                 mem_req_proj[b*3+:3],mem_req_row[b*32+:32],mem_req_col[b*32+:32],
                 mem_req_wdata[b*32+:32],mem_req_tag[b*64+:64]}) === 1'bx)
            $fatal(1,"REQUEST_XZ cycle=%0d",cycles);
          key={mem_req_kind[b*4+:4],mem_req_layer[b*32+:32],mem_req_proj[b*3+:3],
               mem_req_row[b*32+:32],mem_req_col[b*32+:32]};
          slot=lookup(key);
          if (slot<0) $fatal(1,"UNMAPPED_MEMORY kind=%0d layer=%0d proj=%0d row=%h col=%0d",
            mem_req_kind[b*4+:4],mem_req_layer[b*32+:32],mem_req_proj[b*3+:3],
            mem_req_row[b*32+:32],mem_req_col[b*32+:32]);
          if (pending[b]) $fatal(1,"MEMORY_MODEL_BANK_OWNERSHIP");
          pending[b]<=1;
          delay_cycles[b]=(cycles+b*3)%5;
          response_tag[b*64+:64]<=mem_req_tag[b*64+:64];
          if (mem_req_write[b]) begin
            if (consumed[slot]>=counts[slot]) $fatal(1,"UNEXPECTED_WRITE slot=%0d key=%h",slot,key);
            if (mem_req_wdata[b*32+:32] !== expected[starts[slot]+consumed[slot]])
              $fatal(1,"NUMERICAL_WRITE_MISMATCH cycle=%0d slot=%0d kind=%0d layer=%0d proj=%0d row=%h col=%0d occurrence=%0d actual=%h expected=%h",
                cycles,slot,mem_req_kind[b*4+:4],mem_req_layer[b*32+:32],mem_req_proj[b*3+:3],
                mem_req_row[b*32+:32],mem_req_col[b*32+:32],consumed[slot],
                mem_req_wdata[b*32+:32],expected[starts[slot]+consumed[slot]]);
            consumed[slot]=consumed[slot]+1;
            memory[slot]=mem_req_wdata[b*32+:32];
            initialized[slot]=1;
            response_data[b*32+:32]<=0;
            writes=writes+1; write_bytes=write_bytes+4;
          end else begin
            if (initialized[slot]!==1'b1) $fatal(1,"UNINITIALIZED_READ slot=%0d key=%h",slot,key);
            response_data[b*32+:32]<=memory[slot];
            reads=reads+1; read_bytes=read_bytes+4;
            if (mem_req_kind[b*4+:4]==15 && mem_req_proj[b*3+:3]==5)
              expert_bytes_observed=expert_bytes_observed+4;
          end
        end
      end
      if (held_logit && {logit_valid,logit_index,logit_data} !== {1'b1,previous_logit})
        $fatal(1,"LOGIT_UNSTABLE");
      held_logit=logit_valid && !logit_ready;
      previous_logit={logit_index,logit_data};
      if (held_logit) logit_stalls=logit_stalls+1;
      if (logit_valid && logit_ready) begin
        if (compared_logits>=TOKENS*8 ||
            logit_index !== compared_logits%8 || logit_data !== logits[compared_logits])
          $fatal(1,"LOGIT_MISMATCH count=%0d index=%0d actual=%h expected=%h",
            compared_logits,logit_index,logit_data,logits[compared_logits]);
        compared_logits=compared_logits+1;
      end
      if (done) begin
        if (error !== 1'b0 || compared_logits!==(completed+1)*8)
          $fatal(1,"TOKEN_ERROR_OR_PREMATURE_DONE cycle=%0d error=%b logits=%0d reads=%0d writes=%0d",
            cycles,error,compared_logits,reads,writes);
        completed=completed+1;
      end
      if (logit_valid && logit_ready && logit_index==7) begin
        #1;
        if (done !== 1'b1 || token_ready !== 1'b0)
          $fatal(1,"FINAL_LOGIT_COMPLETION_LATENCY");
      end
    end
  end
endmodule
