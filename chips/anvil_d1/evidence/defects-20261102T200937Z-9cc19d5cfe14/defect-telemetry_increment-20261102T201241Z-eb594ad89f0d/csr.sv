
module tb;
  reg clk=0; always #5 clk=~clk;
  reg [0:0] rst_n=0;
reg [0:0] csr_valid=0;
reg [0:0] csr_write=0;
reg [11:0] csr_addr=0;
reg [31:0] csr_wdata=0;
reg [3:0] csr_wstrb=0;
reg [0:0] csr_rsp_ready=0;
reg [0:0] token_accept=0;
reg [0:0] token_complete=0;
reg [0:0] token_error=0;
reg [0:0] reasoning_active=0;
reg [0:0] shared_busy=0;
reg [0:0] prefetch_busy=0;
reg [2:0] domain_id=0;
reg [31:0] cache_read_bytes=0;
reg [31:0] cache_write_bytes=0;
reg [31:0] cache_dense_equiv_bytes=0;
reg [31:0] expert_read_bytes=0;
reg [31:0] expert_dense_equiv_bytes=0;
reg [31:0] other_read_bytes=0;
reg [31:0] other_write_bytes=0;
wire [0:0] csr_ready;
wire [0:0] csr_rsp_valid;
wire [31:0] csr_rdata;
wire [0:0] csr_error;
wire [2:0] domain_select;
wire [31:0] think_begin_token;
wire [31:0] think_end_token;
  anvil_d1_csr_perf #(.VOCAB_SIZE(8)) device (.clk(clk),.rst_n(rst_n),
.csr_valid(csr_valid),
.csr_write(csr_write),
.csr_addr(csr_addr),
.csr_wdata(csr_wdata),
.csr_wstrb(csr_wstrb),
.csr_rsp_ready(csr_rsp_ready),
.token_accept(token_accept),
.token_complete(token_complete),
.token_error(token_error),
.reasoning_active(reasoning_active),
.shared_busy(shared_busy),
.prefetch_busy(prefetch_busy),
.domain_id(domain_id),
.cache_read_bytes(cache_read_bytes),
.cache_write_bytes(cache_write_bytes),
.cache_dense_equiv_bytes(cache_dense_equiv_bytes),
.expert_read_bytes(expert_read_bytes),
.expert_dense_equiv_bytes(expert_dense_equiv_bytes),
.other_read_bytes(other_read_bytes),
.other_write_bytes(other_write_bytes),
.csr_ready(csr_ready),
.csr_rsp_valid(csr_rsp_valid),
.csr_rdata(csr_rdata),
.csr_error(csr_error),
.domain_select(domain_select),
.think_begin_token(think_begin_token),
.think_end_token(think_end_token));
  reg [285-1:0] inputs[0:484-1];
  reg [102-1:0] before_values[0:484-1],after_values[0:484-1];
  integer reset_samples=0;
  task automatic reset_check;
    begin
      if ({csr_ready,csr_rsp_valid,csr_rdata,csr_error,domain_select,think_begin_token,think_end_token} !== 0) $fatal(1,"CSR_RESET_XZ_OR_NONZERO t=%0t",$time);
      reset_samples=reset_samples+1;
    end
  endtask
  always @(posedge clk or negedge clk) if (!rst_n) reset_check();
  initial begin
    rst_n=0;
    $readmemh("checkpoint-images/inputs.hex",inputs);
    $readmemh("checkpoint-images/before.hex",before_values);
    $readmemh("checkpoint-images/after.hex",after_values);
`ifdef VERILATOR
    #1;
`else
    #0;
`endif
    reset_check();
    for (integer edge_index=0;edge_index<484;edge_index=edge_index+1) begin
      @(negedge clk); #1; {rst_n,csr_valid,csr_write,csr_addr,csr_wdata,csr_wstrb,csr_rsp_ready,token_accept,token_complete,token_error,reasoning_active,shared_busy,prefetch_busy,domain_id,cache_read_bytes,cache_write_bytes,cache_dense_equiv_bytes,expert_read_bytes,expert_dense_equiv_bytes,other_read_bytes,other_write_bytes}=inputs[edge_index];
      @(posedge clk);
      if ({csr_ready,csr_rsp_valid,csr_rdata,csr_error,domain_select,think_begin_token,think_end_token} !== before_values[edge_index])
        $fatal(1,"CSR_PRE_EDGE_MISMATCH edge=%0d actual=%h expected=%h",
          edge_index,{csr_ready,csr_rsp_valid,csr_rdata,csr_error,domain_select,think_begin_token,think_end_token},before_values[edge_index]);
      #1;
      if ({csr_ready,csr_rsp_valid,csr_rdata,csr_error,domain_select,think_begin_token,think_end_token} !== after_values[edge_index])
        $fatal(1,"CSR_POST_EDGE_MISMATCH edge=%0d actual=%h expected=%h",
          edge_index,{csr_ready,csr_rsp_valid,csr_rdata,csr_error,domain_select,think_begin_token,think_end_token},after_values[edge_index]);
    end
    if (reset_samples<5) $fatal(1,"CSR_MISSING_RESET_SAMPLES");
    $display("SUMMARY csr_edges=%0d pin_comparisons=%0d reset=%0d",484,484*2,reset_samples);
    $finish;
  end
endmodule
