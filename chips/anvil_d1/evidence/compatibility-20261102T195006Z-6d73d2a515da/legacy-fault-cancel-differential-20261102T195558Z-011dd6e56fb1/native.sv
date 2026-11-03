
module tb;
  localparam B=2, SLOTS=790, WRITES=234, TOKENS=1;
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
  anvil_d1_top #(.MODEL_MODE(1),.PROFILE(3),.NUM_LAYERS(1),.HIDDEN_SIZE(16),.INTERMEDIATE_SIZE(16),.NUM_Q_HEADS(8),.NUM_KV_HEADS(1),.HEAD_DIM(2),.GROUP_SIZE(8),.AWQ_BITS(4),.VOCAB_SIZE(8),.MAX_SEQ_LEN(5),.CACHE_MODE(0),.CACHE_BLOCK(2),.INT4_ASYM(0),.BANKS(B),.QUEUE_DEPTH(3),.TILE_K(8),.TILE_ROWS(3)
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
wire [1-1:0] reference_token_ready;
wire [1-1:0] reference_logit_valid;
wire [32-1:0] reference_logit_index;
wire [32-1:0] reference_logit_data;
wire [1-1:0] reference_done;
wire [1-1:0] reference_error;
wire [1-1:0] reference_cancel_done;
wire [B-1:0] reference_mem_req_valid;
wire [B-1:0] reference_mem_req_write;
wire [B*4-1:0] reference_mem_req_kind;
wire [B*32-1:0] reference_mem_req_layer;
wire [B*3-1:0] reference_mem_req_proj;
wire [B*32-1:0] reference_mem_req_row;
wire [B*32-1:0] reference_mem_req_col;
wire [B*32-1:0] reference_mem_req_wdata;
wire [B*64-1:0] reference_mem_req_tag;
wire [B-1:0] reference_mem_rsp_ready;
  anvil_q3_top #(.PROFILE(3),.NUM_LAYERS(1),.HIDDEN_SIZE(16),.INTERMEDIATE_SIZE(16),.NUM_Q_HEADS(8),.NUM_KV_HEADS(1),.HEAD_DIM(2),.GROUP_SIZE(8),.AWQ_BITS(4),.VOCAB_SIZE(8),.MAX_SEQ_LEN(5),.CACHE_MODE(0),.CACHE_BLOCK(2),.INT4_ASYM(0),.BANKS(B),.QUEUE_DEPTH(3),.TILE_K(8),.TILE_ROWS(3)
  ) parent_device (
    .clk(clk),.rst_n(rst_n),.cancel(cancel),
    .token_valid(token_valid),.token_ready(reference_token_ready),
    .token_id(token_id),.token_pos(token_pos),.new_sequence(new_sequence),.token_phase(token_phase),
    .logit_valid(reference_logit_valid),.logit_ready(logit_ready),
    .logit_index(reference_logit_index),.logit_data(reference_logit_data),.done(reference_done),.error(reference_error),.cancel_done(reference_cancel_done),
    .mem_req_valid(reference_mem_req_valid),.mem_req_ready(mem_req_ready),.mem_req_write(reference_mem_req_write),
    .mem_req_kind(reference_mem_req_kind),.mem_req_layer(reference_mem_req_layer),.mem_req_proj(reference_mem_req_proj),
    .mem_req_row(reference_mem_req_row),.mem_req_col(reference_mem_req_col),.mem_req_wdata(reference_mem_req_wdata),
    .mem_req_tag(reference_mem_req_tag),.mem_rsp_valid(mem_rsp_valid),.mem_rsp_error(mem_rsp_error),
    .mem_rsp_ready(reference_mem_rsp_ready),.mem_rsp_rdata(mem_rsp_rdata),.mem_rsp_tag(mem_rsp_tag)
  );
  integer differential_edges=0;
  task automatic compare_parent;
    begin
      if ({token_ready,logit_valid,logit_index,logit_data,done,error,cancel_done,mem_req_valid,mem_req_write,mem_req_kind,mem_req_layer,mem_req_proj,mem_req_row,mem_req_col,mem_req_wdata,mem_req_tag,mem_rsp_ready} !== {reference_token_ready,reference_logit_valid,reference_logit_index,reference_logit_data,reference_done,reference_error,reference_cancel_done,reference_mem_req_valid,reference_mem_req_write,reference_mem_req_kind,reference_mem_req_layer,reference_mem_req_proj,reference_mem_req_row,reference_mem_req_col,reference_mem_req_wdata,reference_mem_req_tag,reference_mem_rsp_ready})
        $fatal(1,"LEGACY_PUBLIC_PIN_MISMATCH t=%0t",$time);
      differential_edges=differential_edges+1;
    end
  endtask
  always @(posedge clk or negedge clk) begin
    compare_parent();
    #1; compare_parent();
  end

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

    pending_error=0;
    for (experiment=0;experiment<12;experiment=experiment+1) begin
      $display("CASE_START experiment=%0d completed=%0d",experiment,completed);
      expected_error=1; expected_cancel=0; triggered=0;
      inject_error=0; inject_tag=0; freeze_service=0; hold_logits=0; target=-1;
      before_completed=completed; before_cancel=cancellation_completions;
      if (experiment==0) begin
        // Idle cancel must not invent a successful or failed token.
        @(negedge clk); cancel=1;
        @(posedge clk); #1;
        @(negedge clk); cancel=0;
        while (cancellation_completions==before_cancel) @(negedge clk);
        if (completed!=before_completed) $fatal(1,"IDLE_CANCEL_INVENTED_TOKEN");
      end else if (experiment==1) begin
        @(negedge clk); while (!token_ready) @(negedge clk);
        token_valid=1; new_sequence=1; token_id=2; token_pos=0; cancel=1;
        before_accepted=accepted;
        @(posedge clk); #1;
        @(negedge clk); cancel=0; token_valid=0;
        while (cancellation_completions==before_cancel) @(negedge clk);
        if (accepted!=before_accepted || completed!=before_completed)
          $fatal(1,"SIMULTANEOUS_CANCEL_ACCEPTANCE");
      end else if (experiment==2 || experiment==3) begin
        start_token(experiment==2 ? 8 : 2, experiment==3 ? 1 : 0);
        while (completed==before_completed) @(negedge clk);
      end else begin
        // Cancellation during raw absorption, cache commit, routed
        // prefetch and held logits. Errors cover reads, writes, prefetch
        // and a malformed/stale response tag.
        if (experiment==4) target=2;
        if (experiment==5) target=3;
        if (experiment==6) target=4;
        if (experiment==7) begin target=-1; hold_logits=1; end
        if (experiment==8) begin target=0; inject_error=1; end
        if (experiment==9) begin target=1; inject_error=1; end
        if (experiment==10) begin target=4; inject_error=1; end
        if (experiment==11) begin target=0; inject_tag=1; end
        freeze_service=experiment>=4 && experiment<=6;
        start_token(2,0);
        if (experiment>=4 && experiment<=7) begin
          if (experiment==7) begin
            while (logit_valid!==1'b1 || logit_ready!==1'b0) @(negedge clk);
            if (logit_index!==0 || logit_data!==logits[0]) $fatal(1,"UNCHECKED_LOGIT_CANCEL_TARGET");
            logit_cancel_targets=logit_cancel_targets+1;
          end else begin
            // Service earlier requests normally, freezing only after
            // ownership of the selected target has been acquired.
            freeze_service=0;
            while (!triggered) @(negedge clk);
            freeze_service=1;
            if (pending==0) $fatal(1,"CANCEL_WITHOUT_OWNED_TARGET");
            owned_cancel_targets=owned_cancel_targets+1;
          end
          expected_cancel=1;
          cancel=1;
          repeat(3) @(negedge clk);
          cancel=0;
          if (experiment!=7) begin
            repeat(13) begin
              @(negedge clk);
              if (cancel_done!==0 || done!==0 || token_ready!==0)
                $fatal(1,"CANCEL_COMPLETED_BEFORE_DRAIN");
              held_drain_cycles=held_drain_cycles+1;
            end
          end
          freeze_service=0;
          while (cancellation_completions==before_cancel) @(negedge clk);
          if (completed!=before_completed+1) $fatal(1,"CANCEL_LOST_ACTIVE_COMPLETION");
        end else begin
          while (completed==before_completed) @(negedge clk);
          if (!triggered) $fatal(1,"FAULT_NOT_ACTUALLY_INJECTED");
          injected_faults=injected_faults+1;
        end
      end
      while (!token_ready) @(negedge clk);
      if (pending) $fatal(1,"RESTART_BEFORE_DRAIN");
      inject_error=0; inject_tag=0; target=-1; freeze_service=0; hold_logits=0;
      expected_error=0; expected_cancel=0; triggered=0; before_completed=completed;
      start_token(2,0);
      while (completed==before_completed) @(negedge clk);
    end
    // Final complete positive control after the final recovery.
    expected_error=0; before_completed=completed;
    start_token(2,0);
    while (completed==before_completed) @(negedge clk);
    repeat(3) @(negedge clk);
    if (successful_restarts!=13 || error_completions!=10 || cancellation_completions!=6 ||
        owned_cancel_targets!=3 || logit_cancel_targets!=1 || injected_faults!=4 ||
        target_transfers!=7 || cancel_edges==0 || held_drain_cycles!=39 ||
        request_stalls==0 || logit_stalls==0 || reset_samples<5)
      $fatal(1,"FAULT_MISSING_COVERAGE successful=%0d errors=%0d cancellations=%0d owned=%0d logits=%0d injected=%0d targets=%0d held_drain=%0d",
        successful_restarts,error_completions,cancellation_completions,
        owned_cancel_targets,logit_cancel_targets,injected_faults,target_transfers,held_drain_cycles);
    $display("SUMMARY fault_experiments=12 successful_restarts=%0d error_completions=%0d cancellation_completions=%0d checked_writes=%0d reads=%0d owned_cancel_targets=%0d logit_cancel_targets=%0d injected_faults=%0d held_drain_cycles=%0d cycles=%0d",
      successful_restarts,error_completions,cancellation_completions,writes,reads,
      owned_cancel_targets,logit_cancel_targets,injected_faults,held_drain_cycles,cycles);
    $finish;
  end
  reg [B-1:0] pending_error=0;
  reg [B-1:0] pending_bad_tag=0;
  reg [B*64-1:0] correct_tag=0;
  reg expected_error=0,expected_cancel=0,inject_error=0,inject_tag=0;
  reg triggered=0,freeze_service=0,hold_logits=0;
  integer experiment=0,target=-1,before_completed=0,before_cancel=0,before_accepted=0;
  integer successful_restarts=0,error_completions=0,cancellation_completions=0;
  integer owned_cancel_targets=0,logit_cancel_targets=0,injected_faults=0;
  integer target_transfers=0,cancel_edges=0,held_drain_cycles=0;
  function automatic integer target_request(input integer bank);
    begin
      target_request=0;
      if (target==0) target_request=!mem_req_write[bank];
      if (target==1) target_request=mem_req_write[bank];
      if (target==2) target_request=mem_req_kind[bank*4+:4]==1;
      if (target==3) target_request=(mem_req_kind[bank*4+:4]==9 || mem_req_kind[bank*4+:4]==12) && mem_req_write[bank];
      if (target==4) target_request=mem_req_kind[bank*4+:4]==1;
    end
  endfunction
  task automatic start_token(input [31:0] id, pos);
    begin
      @(negedge clk); while (token_ready!==1'b1) @(negedge clk);
      if (pending) $fatal(1,"TOKEN_START_WITH_OWNED_MEMORY");
      for (integer j=0;j<SLOTS;j=j+1) consumed[j]=0;
      compared_logits=0;
      token_id=id; token_pos=pos; token_phase=0; new_sequence=1; token_valid=1;
      @(posedge clk);
      if (token_ready!==1'b1) $fatal(1,"FAULT_STIMULUS_NOT_ACCEPTED");
      @(negedge clk); token_valid=0;
    end
  endtask

  always @(negedge clk) begin
    if (!rst_n) check_reset();
    else begin
      for (integer bank=0;bank<B;bank=bank+1)
        mem_req_ready[bank]=!pending[bank] && (cycles+bank)%7!=0;
      if (!logit_valid) begin logit_ready=0; logit_delay=0; end
      else if (logit_delay<4) begin logit_ready=0; logit_delay=logit_delay+1; end
      else logit_ready=!hold_logits;
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
        if (stalled[b] && !cancel &&
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
          mem_rsp_valid[b]<=0; mem_rsp_error[b]<=0;
          if (pending_bad_tag[b]) begin
            // An injected unsolicited tag does not discharge ownership.
            // Deliver the real matching response afterwards to satisfy
            // eventual-response fairness and permit fault drain.
            pending_bad_tag[b]<=0;
            response_tag[b*64+:64]<=correct_tag[b*64+:64];
            delay_cycles[b]=5;
          end else pending[b]<=0;
        end
        if (pending[b] && !mem_rsp_valid[b] && !freeze_service) begin
          if (delay_cycles[b]==0) begin
            mem_rsp_valid[b]<=1; mem_rsp_error[b]<=pending_error[b];
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
          pending_error[b]<=0; pending_bad_tag[b]<=0;
          correct_tag[b*64+:64]<=mem_req_tag[b*64+:64];
          if (!triggered && target_request(b)) begin
            triggered=1; target_transfers=target_transfers+1;
            if (inject_error) pending_error[b]<=1;
            if (inject_tag) begin
              pending_bad_tag[b]<=1;
              response_tag[b*64+:64]<=mem_req_tag[b*64+:64]^64'h8000000000000000;
            end
          end
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
      if (held_logit && !cancel && {logit_valid,logit_index,logit_data} !== {1'b1,previous_logit})
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
        if (error !== expected_error || (expected_cancel && cancel_done!==1'b1) || pending)
          $fatal(1,"FAULT_COMPLETION_MISMATCH case=%0d actual_error=%b expected_error=%b pending=%b",
            experiment,error,expected_error,pending);
        if (!expected_error) begin
          if (compared_logits!=8) $fatal(1,"RESTART_MISSING_LOGITS");
          for (integer j=0;j<SLOTS;j=j+1)
            if (consumed[j]!==counts[j]) $fatal(1,"RESTART_MISSING_WRITE");
          successful_restarts=successful_restarts+1;
        end else error_completions=error_completions+1;
        completed=completed+1;
      end
      if (cancel_done) begin
        if (pending || mem_req_valid || logit_valid || token_ready)
          $fatal(1,"EARLY_CANCELLATION_COMPLETION");
        cancellation_completions=cancellation_completions+1;
      end
      if (cancel) begin
        if (mem_req_valid!==0 || logit_valid!==0 || token_ready!==0 || done!==0)
          $fatal(1,"CANCEL_EDGE_ACCEPTANCE_OR_TRAFFIC");
        cancel_edges=cancel_edges+1;
      end
      if (logit_valid && logit_ready && logit_index==7) begin
        #1;
        if (done !== 1'b1 || token_ready !== 1'b0)
          $fatal(1,"FINAL_LOGIT_COMPLETION_LATENCY");
      end
    end
  end
endmodule
