
module tb;
  reg clk=0; always #5 clk=~clk;
  reg rst_n,clear=0,snapshot=0;
  reg [35:0] increment=0;
  wire [63:0] live_value,snapshot_value;
  wire overflow;
  anvil_d1_counter64 device(.*);
  integer comparisons=0,reset_samples=0;
  task automatic compare(input [63:0] live_expected,input [63:0] saved_expected,input bit fault);
    begin
      if ({live_value,snapshot_value,overflow} !== {live_expected,saved_expected,fault})
        $fatal(1,"COUNTER_MISMATCH live=%h saved=%h overflow=%b",live_value,snapshot_value,overflow);
      comparisons=comparisons+1;
    end
  endtask
  always @(posedge clk or negedge clk) if (!rst_n) begin
    if ({live_value,snapshot_value,overflow} !== 0) $fatal(1,"COUNTER_RESET_XZ");
    reset_samples=reset_samples+1;
  end
  initial begin
    rst_n=0; #1; compare(0,0,0);
    repeat(2) @(negedge clk); #1; rst_n=1;
    @(negedge clk); increment=36'hfffffffff;
    @(posedge clk); #1; compare(64'hfffffffff,0,0);
    @(posedge clk); #1; compare(64'h1ffffffffe,0,0);
    repeat(268435454) @(posedge clk);
    #1; compare(64'hfffffffff0000000,0,0);
    @(negedge clk); snapshot=1;
    @(posedge clk); #1; compare(64'hffffffffffffffff,64'hfffffffff0000000,1);
    @(negedge clk); snapshot=0;
    @(posedge clk); #1; compare(64'hffffffffffffffff,64'hfffffffff0000000,1);
    @(negedge clk); clear=1;snapshot=1;
    @(posedge clk); #1; compare(0,0,0);
    @(negedge clk); clear=0;snapshot=0;increment=0;
    @(posedge clk); #1; compare(0,0,0);
    if (comparisons!=8 || reset_samples<4) $fatal(1,"COUNTER_MISSING_COVERAGE");
    $display("SUMMARY counter_comparisons=%0d saturation_events=1 low_carries=1 clear_increment_priority=1 reset=%0d",
      comparisons,reset_samples);
    $finish;
  end
endmodule
