
module tb;
  localparam SLOTS=267, WRITES=2197, CASES=13;
  reg clk=0; always #5 clk=~clk;
  reg rst_n,flush=0,cmd_valid=0,cmd_phase=1;
  wire cmd_ready,done,error;
  reg [31:0] cmd_epoch=0,cmd_layer=0,cmd_pos=0;
  wire [63:0] kv_read_bytes,kv_write_bytes,kv_dense_equiv_bytes;
  wire c_req_valid,c_req_write,c_rsp_ready;
  wire [3:0] c_req_kind;
  wire [2:0] c_req_proj;
  wire [31:0] c_req_layer,c_req_row,c_req_col,c_req_wdata;
  reg c_req_ready=0,c_rsp_valid=0,c_rsp_error=0;
  reg [31:0] c_rsp_rdata=0;
  anvil_d1_mla_engine #(.NUM_LAYERS(1),.HIDDEN_SIZE(8),.NUM_Q_HEADS(1),
    .KV_LORA_RANK(3),.QK_NOPE_HEAD_DIM(1),.QK_ROPE_HEAD_DIM(2),
    .V_HEAD_DIM(1),.MAX_SEQ_LEN(3)) device (
    .clk(clk),.rst_n(rst_n),.flush(flush),.cmd_valid(cmd_valid),.cmd_ready(cmd_ready),
    .cmd_epoch(cmd_epoch),.cmd_layer(cmd_layer),.cmd_pos(cmd_pos),.cmd_phase(cmd_phase),
    .done(done),.error(error),.kv_read_bytes(kv_read_bytes),
    .kv_write_bytes(kv_write_bytes),.kv_dense_equiv_bytes(kv_dense_equiv_bytes),
    .c_req_valid(c_req_valid),.c_req_ready(c_req_ready),.c_req_write(c_req_write),
    .c_req_kind(c_req_kind),.c_req_layer(c_req_layer),.c_req_proj(c_req_proj),
    .c_req_row(c_req_row),.c_req_col(c_req_col),.c_req_wdata(c_req_wdata),
    .c_rsp_valid(c_rsp_valid),.c_rsp_ready(c_rsp_ready),.c_rsp_error(c_rsp_error),
    .c_rsp_rdata(c_rsp_rdata)
  );
  reg [102:0] keys[0:SLOTS-1];
  reg [31:0] memory[0:CASES*SLOTS-1],starts[0:CASES*SLOTS-1],counts[0:CASES*SLOTS-1];
  reg initialized[0:CASES*SLOTS-1];
  reg [31:0] expected[0:WRITES-1],positions[0:CASES-1];
  integer consumed[0:CASES*SLOTS-1];
  integer active=0,stimulus=0,cycles=0,reads=0,writes=0,completions=0,accepted=0;
  integer stalls=0,reset_samples=0,cache_reads=0,cache_writes=0,dense_beats=0;
  integer contexts=0,absorption=0,slot,index,response_delay=0;
  reg pending=0,pending_final=0,stalled=0,preedge_done=0;
  reg [31:0] response_data=0;
  reg [136:0] held=0;
  reg [63:0] saved_reads=0,saved_writes=0,saved_dense=0;
  function automatic integer lookup(input [102:0] target);
    integer low,high,middle;
    begin
      low=0; high=SLOTS-1; lookup=-1;
      while (low<=high) begin
        middle=(low+high)/2;
        if (keys[middle]==target) begin lookup=middle; low=high+1; end
        else if (keys[middle]<target) low=middle+1; else high=middle-1;
      end
    end
  endfunction
  task automatic reset_check;
    begin
      if ({cmd_ready,done,error,kv_read_bytes,kv_write_bytes,kv_dense_equiv_bytes,
           c_req_valid,c_req_write,c_req_kind,c_req_layer,c_req_proj,c_req_row,
           c_req_col,c_req_wdata,c_rsp_ready} !== 0) $fatal(1,"MLA_RESET_XZ_OR_NONZERO");
      reset_samples=reset_samples+1;
    end
  endtask
  always @(posedge clk or negedge clk) if (!rst_n) reset_check();
  initial begin
    rst_n=0;
    $readmemh("checkpoint-images/keys.hex",keys);
    $readmemh("checkpoint-images/memory.hex",memory);
    $readmemh("checkpoint-images/initialized.hex",initialized);
    $readmemh("checkpoint-images/starts.hex",starts);
    $readmemh("checkpoint-images/counts.hex",counts);
    $readmemh("checkpoint-images/expected.hex",expected);
    $readmemh("checkpoint-images/positions.hex",positions);
    for (integer j=0;j<CASES*SLOTS;j=j+1) consumed[j]=0;
`ifdef VERILATOR
    #1;
`else
    #0;
`endif
    reset_check(); repeat(2) @(negedge clk); #1; rst_n=1;
    for (stimulus=0;stimulus<CASES;stimulus=stimulus+1) begin
      @(negedge clk); while (cmd_ready!==1'b1) @(negedge clk);
      cmd_epoch=stimulus+1; cmd_pos=positions[stimulus]; cmd_valid=1;
      @(posedge clk);
      if (cmd_ready!==1'b1 || c_req_valid!==0) $fatal(1,"MLA_ACCEPTANCE");
      #1;
      if (cmd_ready!==0 || done!==0 || c_req_valid!==0) $fatal(1,"MLA_POST_ACCEPTANCE");
      @(negedge clk); cmd_valid=0;
      while (completions<=stimulus) @(negedge clk);
      repeat(3) @(negedge clk);
      if ({kv_read_bytes,kv_write_bytes,kv_dense_equiv_bytes} !==
          {saved_reads,saved_writes,saved_dense}) $fatal(1,"MLA_TELEMETRY_UNSTABLE");
    end
    for (integer j=0;j<CASES*SLOTS;j=j+1)
      if (consumed[j]!==counts[j]) $fatal(1,"MLA_MISSING_WRITE index=%0d",j);
    if (writes!=WRITES || contexts!=CASES*3 || absorption!=CASES*144 ||
        accepted!=CASES || completions!=CASES || stalls==0 || reset_samples<5)
      $fatal(1,"MLA_MISSING_COMPARISONS");
    $display("SUMMARY mla_cases=%0d writes=%0d reads=%0d contexts=%0d absorption=%0d stalls=%0d reset=%0d cycles=%0d",
      CASES,writes,reads,contexts,absorption,stalls,reset_samples,cycles);
    $finish;
  end
  always @(negedge clk) if (rst_n) c_req_ready=!pending && cycles%7!=0;
  always @(posedge clk) if (rst_n) begin
    preedge_done=done;
    cycles=cycles+1;
    if (cycles>500000) $fatal(1,"MLA_CYCLE_BOUND");
    if ((^{cmd_ready,done,error,c_req_valid,c_rsp_ready})===1'bx) $fatal(1,"MLA_CONTROL_XZ");
    if (cmd_valid && cmd_ready) begin
      active=stimulus; accepted=accepted+1; cache_reads=0; cache_writes=0; dense_beats=0;
    end
    if (stalled && {c_req_valid,c_req_write,c_req_kind,c_req_layer,c_req_proj,
                   c_req_row,c_req_col,c_req_wdata} !== held) $fatal(1,"MLA_UNSTABLE_REQUEST");
    stalled=c_req_valid && !c_req_ready;
    held={c_req_valid,c_req_write,c_req_kind,c_req_layer,c_req_proj,c_req_row,c_req_col,c_req_wdata};
    if (stalled) stalls=stalls+1;
    if (pending && !c_rsp_valid) begin
      if (response_delay==0) begin c_rsp_valid<=1; c_rsp_rdata<=response_data; end
      else response_delay=response_delay-1;
    end
    if (c_req_valid && c_req_ready) begin
      if (pending || (^{c_req_write,c_req_kind,c_req_layer,c_req_proj,
                       c_req_row,c_req_col,c_req_wdata})===1'bx) $fatal(1,"MLA_REQUEST_XZ_OWNERSHIP");
      slot=lookup({c_req_kind,c_req_layer,c_req_proj,c_req_row,c_req_col});
      if (slot<0) $fatal(1,"MLA_UNMAPPED_MEMORY proj=%0d row=%h col=%0d",c_req_proj,c_req_row,c_req_col);
      index=active*SLOTS+slot;
      pending<=1; response_delay=cycles%5;
      pending_final<=c_req_write && c_req_proj==7 && c_req_row==3 && c_req_col==7;
      if (c_req_kind==15 && c_req_proj==3) begin
        if (c_req_row>positions[active] || c_req_col>=5) $fatal(1,"MLA_EXPANDED_OR_NONCAUSAL_CACHE");
        if (c_req_write) cache_writes=cache_writes+1; else cache_reads=cache_reads+1;
        if (c_req_col==0) dense_beats=dense_beats+1;
      end
      if (c_req_write) begin
        if (consumed[index]>=counts[index] ||
            c_req_wdata !== expected[starts[index]+consumed[index]])
          $fatal(1,"MLA_NUMERICAL_WRITE_MISMATCH case=%0d proj=%0d row=%h col=%0d actual=%h expected=%h",
            active,c_req_proj,c_req_row,c_req_col,c_req_wdata,expected[starts[index]+consumed[index]]);
        consumed[index]=consumed[index]+1; writes=writes+1;
        memory[index]=c_req_wdata; initialized[index]=1; response_data<=0;
        if (c_req_proj==7 && c_req_row==7) contexts=contexts+1;
        if (c_req_proj==1 || c_req_proj==2) absorption=absorption+1;
      end else begin
        if (initialized[index]!==1'b1) $fatal(1,"MLA_UNINITIALIZED_READ");
        response_data<=memory[index]; reads=reads+1;
      end
    end
    if (c_rsp_valid && c_rsp_ready) begin
      if (!pending) $fatal(1,"MLA_UNOWNED_RESPONSE");
      pending<=0; c_rsp_valid<=0;
      if (pending_final) begin
        #1;
        if (done!==1'b1 || error!==0 || cmd_ready!==0) $fatal(1,"MLA_FINAL_ACK_LATENCY");
      end
    end
    if (preedge_done) begin
      if (error!==0 || pending || cache_reads!=2*(positions[active]+1)*5 || cache_writes!=5 ||
          kv_read_bytes!==64'(cache_reads*4) || kv_write_bytes!==64'(cache_writes*4) ||
          kv_dense_equiv_bytes!==64'(dense_beats*(1+2+1)*4))
        $fatal(1,"MLA_COMPLETION_TELEMETRY");
      saved_reads=kv_read_bytes; saved_writes=kv_write_bytes; saved_dense=kv_dense_equiv_bytes;
      completions=completions+1;
      #1;
      if (done!==0 || cmd_ready!==1) $fatal(1,"MLA_COMPLETION_RETIREMENT");
    end
  end
endmodule
