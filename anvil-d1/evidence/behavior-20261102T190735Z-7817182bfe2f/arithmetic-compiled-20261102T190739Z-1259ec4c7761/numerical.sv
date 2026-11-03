module tb; reg clk=0; always #5 clk=~clk;
reg rst_n,flush=0; integer comparisons=0,reset_samples=0,watchdog=0;
always @(posedge clk) begin watchdog=watchdog+1; if(watchdog>500000) $fatal(1,"NUMERICAL_CYCLE_BOUND"); end
reg [31:0] mul32_in_a=0;
reg [31:0] mul32_in_b=0;
wire [63:0] mul32_out_product;
reg mul32_iv=0,mul32_or=0;
wire mul32_ir,mul32_ov;
reg [95:0] mul96_in_a=0;
reg [31:0] mul96_in_b=0;
wire [127:0] mul96_out_product;
reg mul96_iv=0,mul96_or=0;
wire mul96_ir,mul96_ov;
reg [127:0] udiv_numerator=0;
reg [63:0] udiv_denominator=0;
wire [127:0] udiv_quotient;
wire [63:0] udiv_remainder;
wire [0:0] udiv_out_error;
reg udiv_iv=0,udiv_or=0;
wire udiv_ir,udiv_ov;
reg [127:0] sdiv_numerator=0;
reg [31:0] sdiv_denominator=0;
wire [128:0] sdiv_quotient;
wire [31:0] sdiv_remainder;
wire [0:0] sdiv_out_error;
reg sdiv_iv=0,sdiv_or=0;
wire sdiv_ir,sdiv_ov;
reg [127:0] root_radicand=0;
wire [63:0] root_root;
wire [64:0] root_remainder;
reg root_iv=0,root_or=0;
wire root_ir,root_ov;
reg [127:0] add0_in_a=0;
reg [127:0] add0_in_b=0;
wire [127:0] add0_out_sum;
wire [0:0] add0_out_error;
reg add0_iv=0,add0_or=0;
wire add0_ir,add0_ov;
reg [127:0] add1_in_a=0;
reg [127:0] add1_in_b=0;
wire [127:0] add1_out_sum;
wire [0:0] add1_out_error;
reg add1_iv=0,add1_or=0;
wire add1_ir,add1_ov;
reg [127:0] round0_in_value=0;
wire [31:0] round0_out_value;
reg round0_iv=0,round0_or=0;
wire round0_ir,round0_ov;
reg [127:0] round16_in_value=0;
wire [31:0] round16_out_value;
reg round16_iv=0,round16_or=0;
wire round16_ir,round16_ov;
reg [127:0] round24_in_value=0;
wire [31:0] round24_out_value;
reg round24_iv=0,round24_or=0;
wire round24_ir,round24_ov;
reg [127:0] round32_in_value=0;
wire [31:0] round32_out_value;
reg round32_iv=0,round32_or=0;
wire round32_ir,round32_ov;
reg [127:0] round48_in_value=0;
wire [31:0] round48_out_value;
reg round48_iv=0,round48_or=0;
wire round48_ir,round48_ov;
reg [127:0] round96_in_value=0;
wire [31:0] round96_out_value;
reg round96_iv=0,round96_or=0;
wire round96_ir,round96_ov;
reg [32:0] exp_in_x=0;
wire [24:0] exp_out_value;
wire [0:0] exp_out_error;
reg exp_iv=0,exp_or=0;
wire exp_ir,exp_ov;
reg [31:0] silu_in_x=0;
wire [31:0] silu_out_value;
wire [0:0] silu_out_error;
reg silu_iv=0,silu_or=0;
wire silu_ir,silu_ov;
anvil_d1_mul32  mul32_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(mul32_iv),.in_ready(mul32_ir),.out_valid(mul32_ov),.out_ready(mul32_or),.in_a(mul32_in_a),.in_b(mul32_in_b),.out_product(mul32_out_product));
anvil_d1_mul96x32  mul96_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(mul96_iv),.in_ready(mul96_ir),.out_valid(mul96_ov),.out_ready(mul96_or),.in_a(mul96_in_a),.in_b(mul96_in_b),.out_product(mul96_out_product));
anvil_d1_udiv #(.NUM_W(128),.DEN_W(64)) udiv_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(udiv_iv),.in_ready(udiv_ir),.out_valid(udiv_ov),.out_ready(udiv_or),.numerator(udiv_numerator),.denominator(udiv_denominator),.quotient(udiv_quotient),.remainder(udiv_remainder),.out_error(udiv_out_error));
anvil_d1_sdiv #(.NUM_W(128),.DEN_W(32)) sdiv_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(sdiv_iv),.in_ready(sdiv_ir),.out_valid(sdiv_ov),.out_ready(sdiv_or),.numerator(sdiv_numerator),.denominator(sdiv_denominator),.quotient(sdiv_quotient),.remainder(sdiv_remainder),.out_error(sdiv_out_error));
anvil_d1_isqrt  root_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(root_iv),.in_ready(root_ir),.out_valid(root_ov),.out_ready(root_or),.radicand(root_radicand),.root(root_root),.remainder(root_remainder));
anvil_d1_add128 #(.SUBTRACT(0)) add0_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(add0_iv),.in_ready(add0_ir),.out_valid(add0_ov),.out_ready(add0_or),.in_a(add0_in_a),.in_b(add0_in_b),.out_sum(add0_out_sum),.out_error(add0_out_error));
anvil_d1_add128 #(.SUBTRACT(1)) add1_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(add1_iv),.in_ready(add1_ir),.out_valid(add1_ov),.out_ready(add1_or),.in_a(add1_in_a),.in_b(add1_in_b),.out_sum(add1_out_sum),.out_error(add1_out_error));
anvil_d1_round_sat #(.SHIFT(0)) round0_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(round0_iv),.in_ready(round0_ir),.out_valid(round0_ov),.out_ready(round0_or),.in_value(round0_in_value),.out_value(round0_out_value));
anvil_d1_round_sat #(.SHIFT(16)) round16_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(round16_iv),.in_ready(round16_ir),.out_valid(round16_ov),.out_ready(round16_or),.in_value(round16_in_value),.out_value(round16_out_value));
anvil_d1_round_sat #(.SHIFT(24)) round24_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(round24_iv),.in_ready(round24_ir),.out_valid(round24_ov),.out_ready(round24_or),.in_value(round24_in_value),.out_value(round24_out_value));
anvil_d1_round_sat #(.SHIFT(32)) round32_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(round32_iv),.in_ready(round32_ir),.out_valid(round32_ov),.out_ready(round32_or),.in_value(round32_in_value),.out_value(round32_out_value));
anvil_d1_round_sat #(.SHIFT(48)) round48_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(round48_iv),.in_ready(round48_ir),.out_valid(round48_ov),.out_ready(round48_or),.in_value(round48_in_value),.out_value(round48_out_value));
anvil_d1_round_sat #(.SHIFT(96)) round96_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(round96_iv),.in_ready(round96_ir),.out_valid(round96_ov),.out_ready(round96_or),.in_value(round96_in_value),.out_value(round96_out_value));
anvil_d1_exp  exp_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(exp_iv),.in_ready(exp_ir),.out_valid(exp_ov),.out_ready(exp_or),.in_x(exp_in_x),.out_value(exp_out_value),.out_error(exp_out_error));
anvil_d1_silu  silu_device (.clk(clk),.rst_n(rst_n),.flush(flush),.in_valid(silu_iv),.in_ready(silu_ir),.out_valid(silu_ov),.out_ready(silu_or),.in_x(silu_in_x),.out_value(silu_out_value),.out_error(silu_out_error));
task automatic check_reset; begin
if ({mul32_ir,mul32_ov,mul32_out_product,mul96_ir,mul96_ov,mul96_out_product,udiv_ir,udiv_ov,udiv_quotient,udiv_remainder,udiv_out_error,sdiv_ir,sdiv_ov,sdiv_quotient,sdiv_remainder,sdiv_out_error,root_ir,root_ov,root_root,root_remainder,add0_ir,add0_ov,add0_out_sum,add0_out_error,add1_ir,add1_ov,add1_out_sum,add1_out_error,round0_ir,round0_ov,round0_out_value,round16_ir,round16_ov,round16_out_value,round24_ir,round24_ov,round24_out_value,round32_ir,round32_ov,round32_out_value,round48_ir,round48_ov,round48_out_value,round96_ir,round96_ov,round96_out_value,exp_ir,exp_ov,exp_out_value,exp_out_error,silu_ir,silu_ov,silu_out_value,silu_out_error} !== 0) $fatal(1,"RESET_XZ_OR_NONZERO t=%0t",$time);
reset_samples=reset_samples+1; end endtask
always @(posedge clk or negedge clk) if (!rst_n) check_reset();
task automatic run_mul32(input integer index);
reg [64:0] held;
integer elapsed;
begin
@(negedge clk);
while (mul32_ir !== 1'b1) @(negedge clk);
case(index)
0: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00000000; end
1: begin mul32_in_a=32'h00000001; mul32_in_b=32'hffffffff; end
2: begin mul32_in_a=32'h80000000; mul32_in_b=32'h80000000; end
3: begin mul32_in_a=32'h80000000; mul32_in_b=32'h7fffffff; end
4: begin mul32_in_a=32'h7fffffff; mul32_in_b=32'h7fffffff; end
5: begin mul32_in_a=32'h973beda4; mul32_in_b=32'h57946374; end
6: begin mul32_in_a=32'hb66ef2b9; mul32_in_b=32'h53fa9e5e; end
7: begin mul32_in_a=32'h1c9cec60; mul32_in_b=32'h3927cc6b; end
8: begin mul32_in_a=32'h46697096; mul32_in_b=32'h65d65714; end
9: begin mul32_in_a=32'h9e1027f6; mul32_in_b=32'he1e80913; end
10: begin mul32_in_a=32'hb3c3c314; mul32_in_b=32'h3ff6876f; end
11: begin mul32_in_a=32'h92bdf714; mul32_in_b=32'h186fb230; end
12: begin mul32_in_a=32'hadd30305; mul32_in_b=32'h19975f63; end
13: begin mul32_in_a=32'h5e88ab6b; mul32_in_b=32'h5468bb88; end
14: begin mul32_in_a=32'hd2ea32ed; mul32_in_b=32'hba8594eb; end
15: begin mul32_in_a=32'h4813ab2a; mul32_in_b=32'h4a134c1c; end
16: begin mul32_in_a=32'h90daeaf4; mul32_in_b=32'hb720d6b8; end
17: begin mul32_in_a=32'hc8124549; mul32_in_b=32'h012bab3f; end
18: begin mul32_in_a=32'h2402d001; mul32_in_b=32'h72432c08; end
19: begin mul32_in_a=32'h731103c8; mul32_in_b=32'h7dd2d03d; end
20: begin mul32_in_a=32'h6b57e362; mul32_in_b=32'h7c74916e; end
21: begin mul32_in_a=32'h37676e4f; mul32_in_b=32'h313e63c4; end
22: begin mul32_in_a=32'h15596641; mul32_in_b=32'he1c58629; end
23: begin mul32_in_a=32'h67dd0a78; mul32_in_b=32'hf100eb21; end
24: begin mul32_in_a=32'h85ab390c; mul32_in_b=32'h4b59da8e; end
25: begin mul32_in_a=32'hf6d59c68; mul32_in_b=32'haaedabf7; end
26: begin mul32_in_a=32'hb79178b6; mul32_in_b=32'h09918c4d; end
27: begin mul32_in_a=32'h2bf72459; mul32_in_b=32'hbd9777a7; end
28: begin mul32_in_a=32'ha5da68b2; mul32_in_b=32'h79334ee3; end
29: begin mul32_in_a=32'h7f743d70; mul32_in_b=32'h70b8e5a4; end
30: begin mul32_in_a=32'h05133ee6; mul32_in_b=32'h94011741; end
31: begin mul32_in_a=32'hb87ccfd6; mul32_in_b=32'h0d8b2a04; end
32: begin mul32_in_a=32'h322018ef; mul32_in_b=32'h244ad34d; end
33: begin mul32_in_a=32'h451c6f2e; mul32_in_b=32'hdf13f7f8; end
34: begin mul32_in_a=32'h9c6f1174; mul32_in_b=32'hc093c759; end
35: begin mul32_in_a=32'h442d1ebd; mul32_in_b=32'had873e00; end
36: begin mul32_in_a=32'hcdb57d9b; mul32_in_b=32'h96a5de21; end
37: begin mul32_in_a=32'hbfa8bf6f; mul32_in_b=32'hc9858631; end
38: begin mul32_in_a=32'h1749ab3a; mul32_in_b=32'h9d79494b; end
39: begin mul32_in_a=32'h8c7caf44; mul32_in_b=32'hecf2ff46; end
40: begin mul32_in_a=32'h13b2594d; mul32_in_b=32'h6204d52e; end
41: begin mul32_in_a=32'hf78944b4; mul32_in_b=32'h44431924; end
42: begin mul32_in_a=32'h35865337; mul32_in_b=32'hec371e26; end
43: begin mul32_in_a=32'hc1570a38; mul32_in_b=32'hd2d38d49; end
44: begin mul32_in_a=32'hdb7b5b97; mul32_in_b=32'ha50e3944; end
45: begin mul32_in_a=32'h1184a2c2; mul32_in_b=32'hf36f0424; end
46: begin mul32_in_a=32'h55947fe4; mul32_in_b=32'h5c32cde0; end
47: begin mul32_in_a=32'h4f390b19; mul32_in_b=32'he101f29b; end
48: begin mul32_in_a=32'hc3b0e883; mul32_in_b=32'h01070cc1; end
49: begin mul32_in_a=32'hefcc5b2a; mul32_in_b=32'h38e4bda2; end
50: begin mul32_in_a=32'h708b29f9; mul32_in_b=32'hc4e631f0; end
51: begin mul32_in_a=32'he373f485; mul32_in_b=32'h014deac9; end
52: begin mul32_in_a=32'hc465e2a3; mul32_in_b=32'hf36cf615; end
53: begin mul32_in_a=32'h00000001; mul32_in_b=32'h00010000; end
54: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
55: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
56: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
57: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
58: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
59: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
60: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
61: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
62: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
63: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
64: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
65: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
66: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
67: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
68: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
69: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
70: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
71: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
72: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
73: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
74: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
75: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
76: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
77: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
78: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
79: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
80: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
81: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
82: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
83: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
84: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
85: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
86: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
87: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
88: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
89: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
90: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
91: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
92: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
93: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
94: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
95: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
96: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
97: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
98: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
99: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
100: begin mul32_in_a=32'h00000000; mul32_in_b=32'h00010000; end
101: begin mul32_in_a=32'h80000000; mul32_in_b=32'h7fffffff; end
102: begin mul32_in_a=32'h7fffffff; mul32_in_b=32'h80000000; end
103: begin mul32_in_a=32'h80000000; mul32_in_b=32'h7fffffff; end
104: begin mul32_in_a=32'h7fffffff; mul32_in_b=32'h80000000; end
105: begin mul32_in_a=32'h80000000; mul32_in_b=32'h7fffffff; end
106: begin mul32_in_a=32'h7fffffff; mul32_in_b=32'h80000000; end
107: begin mul32_in_a=32'h80000000; mul32_in_b=32'h7fffffff; end
108: begin mul32_in_a=32'h7fffffff; mul32_in_b=32'h80000000; end
109: begin mul32_in_a=32'h80000000; mul32_in_b=32'h7fffffff; end
110: begin mul32_in_a=32'h7fffffff; mul32_in_b=32'h80000000; end
111: begin mul32_in_a=32'h80000000; mul32_in_b=32'h7fffffff; end
112: begin mul32_in_a=32'h7fffffff; mul32_in_b=32'h80000000; end
113: begin mul32_in_a=32'h80000000; mul32_in_b=32'h7fffffff; end
114: begin mul32_in_a=32'h7fffffff; mul32_in_b=32'h80000000; end
115: begin mul32_in_a=32'h80000000; mul32_in_b=32'h7fffffff; end
116: begin mul32_in_a=32'h7fffffff; mul32_in_b=32'h80000000; end
117: begin mul32_in_a=32'h80000000; mul32_in_b=32'h7fffffff; end
118: begin mul32_in_a=32'h7fffffff; mul32_in_b=32'h80000000; end
119: begin mul32_in_a=32'h80000000; mul32_in_b=32'h7fffffff; end
120: begin mul32_in_a=32'h7fffffff; mul32_in_b=32'h80000000; end
121: begin mul32_in_a=32'h80000000; mul32_in_b=32'h7fffffff; end
122: begin mul32_in_a=32'h7fffffff; mul32_in_b=32'h80000000; end
123: begin mul32_in_a=32'h80000000; mul32_in_b=32'h7fffffff; end
124: begin mul32_in_a=32'h7fffffff; mul32_in_b=32'h80000000; end
125: begin mul32_in_a=32'hfffffff1; mul32_in_b=32'h25ca4cef; end
126: begin mul32_in_a=32'hffffffff; mul32_in_b=32'h3672fed3; end
127: begin mul32_in_a=32'hfffffffc; mul32_in_b=32'he6f261d7; end
128: begin mul32_in_a=32'hfffffffa; mul32_in_b=32'hf7217fc3; end
129: begin mul32_in_a=32'h0000000d; mul32_in_b=32'h3cb87e72; end
130: begin mul32_in_a=32'h00000005; mul32_in_b=32'heeb37cdd; end
131: begin mul32_in_a=32'hfffffffd; mul32_in_b=32'h125433e5; end
132: begin mul32_in_a=32'h00000000; mul32_in_b=32'h03ebcf1c; end
133: begin mul32_in_a=32'hfffffff3; mul32_in_b=32'hc42c694e; end
134: begin mul32_in_a=32'hfffffff7; mul32_in_b=32'h23c0c234; end
135: begin mul32_in_a=32'hfffffffa; mul32_in_b=32'hf1c8cd32; end
136: begin mul32_in_a=32'h0000000d; mul32_in_b=32'h2f98fb3e; end
137: begin mul32_in_a=32'h0000000b; mul32_in_b=32'hdb9a0af2; end
138: begin mul32_in_a=32'hfffffff0; mul32_in_b=32'hddc5201b; end
139: begin mul32_in_a=32'hfffffff4; mul32_in_b=32'hea716076; end
140: begin mul32_in_a=32'hfffffff4; mul32_in_b=32'hcb58bd74; end
141: begin mul32_in_a=32'h00000005; mul32_in_b=32'hda8c7f38; end
142: begin mul32_in_a=32'h00000005; mul32_in_b=32'hf92b629d; end
143: begin mul32_in_a=32'h00000003; mul32_in_b=32'h13fc7825; end
144: begin mul32_in_a=32'hfffffffb; mul32_in_b=32'h09fbea2a; end
145: begin mul32_in_a=32'hfffffffc; mul32_in_b=32'hfb529f22; end
146: begin mul32_in_a=32'h0000000a; mul32_in_b=32'hee428d6e; end
147: begin mul32_in_a=32'hfffffff3; mul32_in_b=32'hd55a1427; end
148: begin mul32_in_a=32'hfffffffc; mul32_in_b=32'h0e4d5630; end
149: begin mul32_in_a=32'h0000ffec; mul32_in_b=32'h3864102d; end
150: begin mul32_in_a=32'hffff4005; mul32_in_b=32'h3c814451; end
151: begin mul32_in_a=32'h00002433; mul32_in_b=32'h19893766; end
152: begin mul32_in_a=32'hffff10ff; mul32_in_b=32'h0f9f5039; end
153: begin mul32_in_a=32'hffff11d8; mul32_in_b=32'h246bca62; end
154: begin mul32_in_a=32'hffff8d05; mul32_in_b=32'hff1db77f; end
155: begin mul32_in_a=32'h00009c1c; mul32_in_b=32'h118844ca; end
156: begin mul32_in_a=32'hffff713d; mul32_in_b=32'h028bd31d; end
157: begin mul32_in_a=32'hffff5395; mul32_in_b=32'h03aa04ba; end
158: begin mul32_in_a=32'hffffd162; mul32_in_b=32'h00c4159a; end
159: begin mul32_in_a=32'h00004c7c; mul32_in_b=32'he5784f97; end
160: begin mul32_in_a=32'h0000db02; mul32_in_b=32'h24467fea; end
161: begin mul32_in_a=32'hfffff3c4; mul32_in_b=32'hf56e8a61; end
162: begin mul32_in_a=32'h0000abd6; mul32_in_b=32'h2d6663e2; end
163: begin mul32_in_a=32'hffffdab7; mul32_in_b=32'h106e3f3f; end
164: begin mul32_in_a=32'hffff21f3; mul32_in_b=32'h2570ad6c; end
165: begin mul32_in_a=32'h0000b4d1; mul32_in_b=32'he6821653; end
166: begin mul32_in_a=32'h00007d36; mul32_in_b=32'hd34259aa; end
167: begin mul32_in_a=32'hffff7a48; mul32_in_b=32'hf8433ad4; end
168: begin mul32_in_a=32'hffff69fb; mul32_in_b=32'hcd3acf6d; end
169: begin mul32_in_a=32'hffff239d; mul32_in_b=32'h119f10e5; end
170: begin mul32_in_a=32'h00001593; mul32_in_b=32'hc7e4391a; end
171: begin mul32_in_a=32'hffffc727; mul32_in_b=32'h346d6e72; end
172: begin mul32_in_a=32'hffffd19e; mul32_in_b=32'hc20cd4ed; end
173: begin mul32_in_a=32'hfffffff5; mul32_in_b=32'he468b517; end
174: begin mul32_in_a=32'hfffffff8; mul32_in_b=32'hfd055041; end
175: begin mul32_in_a=32'hfffffff9; mul32_in_b=32'h084eb6bd; end
176: begin mul32_in_a=32'h0000000f; mul32_in_b=32'hdc7e8861; end
177: begin mul32_in_a=32'h0000000a; mul32_in_b=32'hfff497df; end
178: begin mul32_in_a=32'hfffffff8; mul32_in_b=32'h0fd29f52; end
179: begin mul32_in_a=32'h00000007; mul32_in_b=32'hc3bf75cd; end
180: begin mul32_in_a=32'h00000005; mul32_in_b=32'hf5c5fe96; end
181: begin mul32_in_a=32'hfffffff6; mul32_in_b=32'hc994946c; end
182: begin mul32_in_a=32'hfffffffe; mul32_in_b=32'hc745b1a7; end
183: begin mul32_in_a=32'hfffffff7; mul32_in_b=32'h38a950bb; end
184: begin mul32_in_a=32'h00000004; mul32_in_b=32'h2215bbd7; end
185: begin mul32_in_a=32'hfffffffb; mul32_in_b=32'h1b04e6f0; end
186: begin mul32_in_a=32'hfffffffc; mul32_in_b=32'h2ae563a0; end
187: begin mul32_in_a=32'h0000000e; mul32_in_b=32'h2549eb17; end
188: begin mul32_in_a=32'hfffffff0; mul32_in_b=32'h1de50da0; end
189: begin mul32_in_a=32'hfffffffc; mul32_in_b=32'hd68da04c; end
190: begin mul32_in_a=32'hfffffffb; mul32_in_b=32'h2b8fd1af; end
191: begin mul32_in_a=32'h00000003; mul32_in_b=32'hf52543aa; end
192: begin mul32_in_a=32'h00000007; mul32_in_b=32'hde681f3c; end
193: begin mul32_in_a=32'hfffffff1; mul32_in_b=32'h0325a765; end
194: begin mul32_in_a=32'h0000000c; mul32_in_b=32'heaecd35a; end
195: begin mul32_in_a=32'hfffffff1; mul32_in_b=32'h21c12b47; end
196: begin mul32_in_a=32'hfffffff4; mul32_in_b=32'hf9c5d4dd; end
default: $fatal(1,"BAD_CASE");
endcase
mul32_iv=1; @(posedge clk);
if (mul32_ir !== 1'b1) $fatal(1,"ACCEPT_mul32");
#1; elapsed=0;
repeat (3) begin
if (mul32_ov !== 1'b0) $fatal(1,"EARLY_VALID_mul32 edge=%0d",elapsed);
@(negedge clk); mul32_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
if (mul32_ov !== 1'b1) $fatal(1,"LATE_VALID_mul32 edge=%0d",elapsed);
case(index)
0: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=0 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
1: begin if (mul32_out_product !== 64'hffffffffffffffff) $fatal(1,"NUMERICAL_mul32_out_product case=1 actual=%h expected=%h",mul32_out_product,64'hffffffffffffffff); end
2: begin if (mul32_out_product !== 64'h4000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=2 actual=%h expected=%h",mul32_out_product,64'h4000000000000000); end
3: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=3 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
4: begin if (mul32_out_product !== 64'h3fffffff00000001) $fatal(1,"NUMERICAL_mul32_out_product case=4 actual=%h expected=%h",mul32_out_product,64'h3fffffff00000001); end
5: begin if (mul32_out_product !== 64'hdc28a3b4d2de1a50) $fatal(1,"NUMERICAL_mul32_out_product case=5 actual=%h expected=%h",mul32_out_product,64'hdc28a3b4d2de1a50); end
6: begin if (mul32_out_product !== 64'he7ddf3887a354dee) $fatal(1,"NUMERICAL_mul32_out_product case=6 actual=%h expected=%h",mul32_out_product,64'he7ddf3887a354dee); end
7: begin if (mul32_out_product !== 64'h0663636264934c20) $fatal(1,"NUMERICAL_mul32_out_product case=7 actual=%h expected=%h",mul32_out_product,64'h0663636264934c20); end
8: begin if (mul32_out_product !== 64'h1c028d82a0e3c5b8) $fatal(1,"NUMERICAL_mul32_out_product case=8 actual=%h expected=%h",mul32_out_product,64'h1c028d82a0e3c5b8); end
9: begin if (mul32_out_product !== 64'h0b834654b98a9d42) $fatal(1,"NUMERICAL_mul32_out_product case=9 actual=%h expected=%h",mul32_out_product,64'h0b834654b98a9d42); end
10: begin if (mul32_out_product !== 64'hecf3c2ca8ef921ac) $fatal(1,"NUMERICAL_mul32_out_product case=10 actual=%h expected=%h",mul32_out_product,64'hecf3c2ca8ef921ac); end
11: begin if (mul32_out_product !== 64'hf592237b9b163bc0) $fatal(1,"NUMERICAL_mul32_out_product case=11 actual=%h expected=%h",mul32_out_product,64'hf592237b9b163bc0); end
12: begin if (mul32_out_product !== 64'hf7c90423cbac05ef) $fatal(1,"NUMERICAL_mul32_out_product case=12 actual=%h expected=%h",mul32_out_product,64'hf7c90423cbac05ef); end
13: begin if (mul32_out_product !== 64'h1f2b8504cd4a39d8) $fatal(1,"NUMERICAL_mul32_out_product case=13 actual=%h expected=%h",mul32_out_product,64'h1f2b8504cd4a39d8); end
14: begin if (mul32_out_product !== 64'h0c3c6f85a98ec38f) $fatal(1,"NUMERICAL_mul32_out_product case=14 actual=%h expected=%h",mul32_out_product,64'h0c3c6f85a98ec38f); end
15: begin if (mul32_out_product !== 64'h14db1e5d91153098) $fatal(1,"NUMERICAL_mul32_out_product case=15 actual=%h expected=%h",mul32_out_product,64'h14db1e5d91153098); end
16: begin if (mul32_out_product !== 64'h1fa35124e840d760) $fatal(1,"NUMERICAL_mul32_out_product case=16 actual=%h expected=%h",mul32_out_product,64'h1fa35124e840d760); end
17: begin if (mul32_out_product !== 64'hffbe87ed5d09cff7) $fatal(1,"NUMERICAL_mul32_out_product case=17 actual=%h expected=%h",mul32_out_product,64'hffbe87ed5d09cff7); end
18: begin if (mul32_out_product !== 64'h1012b38e7e19ac08) $fatal(1,"NUMERICAL_mul32_out_product case=18 actual=%h expected=%h",mul32_out_product,64'h1012b38e7e19ac08); end
19: begin if (mul32_out_product !== 64'h388e1067003066a8) $fatal(1,"NUMERICAL_mul32_out_product case=19 actual=%h expected=%h",mul32_out_product,64'h388e1067003066a8); end
20: begin if (mul32_out_product !== 64'h342f72f167f6361c) $fatal(1,"NUMERICAL_mul32_out_product case=20 actual=%h expected=%h",mul32_out_product,64'h342f72f167f6361c); end
21: begin if (mul32_out_product !== 64'h0aa84cc140fb017c) $fatal(1,"NUMERICAL_mul32_out_product case=21 actual=%h expected=%h",mul32_out_product,64'h0aa84cc140fb017c); end
22: begin if (mul32_out_product !== 64'hfd7aa59a07dc6669) $fatal(1,"NUMERICAL_mul32_out_product case=22 actual=%h expected=%h",mul32_out_product,64'hfd7aa59a07dc6669); end
23: begin if (mul32_out_product !== 64'hf9ea6bc8441a8178) $fatal(1,"NUMERICAL_mul32_out_product case=23 actual=%h expected=%h",mul32_out_product,64'hf9ea6bc8441a8178); end
24: begin if (mul32_out_product !== 64'hdbfe39cd4cb9dca8) $fatal(1,"NUMERICAL_mul32_out_product case=24 actual=%h expected=%h",mul32_out_product,64'hdbfe39cd4cb9dca8); end
25: begin if (mul32_out_product !== 64'h030bbb0eb3db6058) $fatal(1,"NUMERICAL_mul32_out_product case=25 actual=%h expected=%h",mul32_out_product,64'h030bbb0eb3db6058); end
26: begin if (mul32_out_product !== 64'hfd4aeef189dad6be) $fatal(1,"NUMERICAL_mul32_out_product case=26 actual=%h expected=%h",mul32_out_product,64'hfd4aeef189dad6be); end
27: begin if (mul32_out_product !== 64'hf49854cfb59d150f) $fatal(1,"NUMERICAL_mul32_out_product case=27 actual=%h expected=%h",mul32_out_product,64'hf49854cfb59d150f); end
28: begin if (mul32_out_product !== 64'hd5522a379a0711d6) $fatal(1,"NUMERICAL_mul32_out_product case=28 actual=%h expected=%h",mul32_out_product,64'hd5522a379a0711d6); end
29: begin if (mul32_out_product !== 64'h381ee8c1c9ec8bc0) $fatal(1,"NUMERICAL_mul32_out_product case=29 actual=%h expected=%h",mul32_out_product,64'h381ee8c1c9ec8bc0); end
30: begin if (mul32_out_product !== 64'hfddbe7003b6fa266) $fatal(1,"NUMERICAL_mul32_out_product case=30 actual=%h expected=%h",mul32_out_product,64'hfddbe7003b6fa266); end
31: begin if (mul32_out_product !== 64'hfc377696133e5b58) $fatal(1,"NUMERICAL_mul32_out_product case=31 actual=%h expected=%h",mul32_out_product,64'hfc377696133e5b58); end
32: begin if (mul32_out_product !== 64'h071b2a28594a7ce3) $fatal(1,"NUMERICAL_mul32_out_product case=32 actual=%h expected=%h",mul32_out_product,64'h071b2a28594a7ce3); end
33: begin if (mul32_out_product !== 64'hf71cb9b8b53b1690) $fatal(1,"NUMERICAL_mul32_out_product case=33 actual=%h expected=%h",mul32_out_product,64'hf71cb9b8b53b1690); end
34: begin if (mul32_out_product !== 64'h18aac1e1beca3d54) $fatal(1,"NUMERICAL_mul32_out_product case=34 actual=%h expected=%h",mul32_out_product,64'h18aac1e1beca3d54); end
35: begin if (mul32_out_product !== 64'hea096356dc1cc600) $fatal(1,"NUMERICAL_mul32_out_product case=35 actual=%h expected=%h",mul32_out_product,64'hea096356dc1cc600); end
36: begin if (mul32_out_product !== 64'h14b24454ae389afb) $fatal(1,"NUMERICAL_mul32_out_product case=36 actual=%h expected=%h",mul32_out_product,64'h14b24454ae389afb); end
37: begin if (mul32_out_product !== 64'h0db12fd09f2bbe3f) $fatal(1,"NUMERICAL_mul32_out_product case=37 actual=%h expected=%h",mul32_out_product,64'h0db12fd09f2bbe3f); end
38: begin if (mul32_out_product !== 64'hf7098b4554d2b3fe) $fatal(1,"NUMERICAL_mul32_out_product case=38 actual=%h expected=%h",mul32_out_product,64'hf7098b4554d2b3fe); end
39: begin if (mul32_out_product !== 64'h08989cfcfaf4a898) $fatal(1,"NUMERICAL_mul32_out_product case=39 actual=%h expected=%h",mul32_out_product,64'h08989cfcfaf4a898); end
40: begin if (mul32_out_product !== 64'h078aa55fcd8d1cd6) $fatal(1,"NUMERICAL_mul32_out_product case=40 actual=%h expected=%h",mul32_out_product,64'h078aa55fcd8d1cd6); end
41: begin if (mul32_out_product !== 64'hfdbe3e58021f3d50) $fatal(1,"NUMERICAL_mul32_out_product case=41 actual=%h expected=%h",mul32_out_product,64'hfdbe3e58021f3d50); end
42: begin if (mul32_out_product !== 64'hfbdd07a94481cc2a) $fatal(1,"NUMERICAL_mul32_out_product case=42 actual=%h expected=%h",mul32_out_product,64'hfbdd07a94481cc2a); end
43: begin if (mul32_out_product !== 64'h0b0e94526e9ac1f8) $fatal(1,"NUMERICAL_mul32_out_product case=43 actual=%h expected=%h",mul32_out_product,64'h0b0e94526e9ac1f8); end
44: begin if (mul32_out_product !== 64'h0cf91f05196af31c) $fatal(1,"NUMERICAL_mul32_out_product case=44 actual=%h expected=%h",mul32_out_product,64'h0cf91f05196af31c); end
45: begin if (mul32_out_product !== 64'hff23dc87414feb48) $fatal(1,"NUMERICAL_mul32_out_product case=45 actual=%h expected=%h",mul32_out_product,64'hff23dc87414feb48); end
46: begin if (mul32_out_product !== 64'h1ed259c9b6e17b80) $fatal(1,"NUMERICAL_mul32_out_product case=46 actual=%h expected=%h",mul32_out_product,64'h1ed259c9b6e17b80); end
47: begin if (mul32_out_product !== 64'hf668b1f4e8205a23) $fatal(1,"NUMERICAL_mul32_out_product case=47 actual=%h expected=%h",mul32_out_product,64'hf668b1f4e8205a23); end
48: begin if (mul32_out_product !== 64'hffc207bdb1da6ec3) $fatal(1,"NUMERICAL_mul32_out_product case=48 actual=%h expected=%h",mul32_out_product,64'hffc207bdb1da6ec3); end
49: begin if (mul32_out_product !== 64'hfc6639f20007b294) $fatal(1,"NUMERICAL_mul32_out_product case=49 actual=%h expected=%h",mul32_out_product,64'hfc6639f20007b294); end
50: begin if (mul32_out_product !== 64'he60495257f360270) $fatal(1,"NUMERICAL_mul32_out_product case=50 actual=%h expected=%h",mul32_out_product,64'he60495257f360270); end
51: begin if (mul32_out_product !== 64'hffdac3a6a48d8e6d) $fatal(1,"NUMERICAL_mul32_out_product case=51 actual=%h expected=%h",mul32_out_product,64'hffdac3a6a48d8e6d); end
52: begin if (mul32_out_product !== 64'h02ed752e59e8395f) $fatal(1,"NUMERICAL_mul32_out_product case=52 actual=%h expected=%h",mul32_out_product,64'h02ed752e59e8395f); end
53: begin if (mul32_out_product !== 64'h0000000000010000) $fatal(1,"NUMERICAL_mul32_out_product case=53 actual=%h expected=%h",mul32_out_product,64'h0000000000010000); end
54: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=54 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
55: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=55 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
56: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=56 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
57: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=57 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
58: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=58 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
59: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=59 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
60: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=60 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
61: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=61 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
62: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=62 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
63: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=63 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
64: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=64 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
65: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=65 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
66: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=66 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
67: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=67 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
68: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=68 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
69: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=69 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
70: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=70 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
71: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=71 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
72: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=72 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
73: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=73 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
74: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=74 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
75: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=75 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
76: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=76 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
77: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=77 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
78: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=78 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
79: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=79 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
80: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=80 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
81: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=81 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
82: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=82 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
83: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=83 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
84: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=84 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
85: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=85 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
86: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=86 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
87: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=87 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
88: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=88 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
89: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=89 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
90: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=90 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
91: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=91 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
92: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=92 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
93: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=93 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
94: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=94 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
95: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=95 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
96: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=96 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
97: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=97 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
98: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=98 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
99: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=99 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
100: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=100 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
101: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=101 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
102: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=102 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
103: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=103 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
104: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=104 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
105: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=105 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
106: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=106 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
107: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=107 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
108: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=108 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
109: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=109 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
110: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=110 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
111: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=111 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
112: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=112 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
113: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=113 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
114: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=114 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
115: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=115 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
116: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=116 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
117: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=117 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
118: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=118 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
119: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=119 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
120: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=120 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
121: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=121 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
122: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=122 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
123: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=123 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
124: begin if (mul32_out_product !== 64'hc000000080000000) $fatal(1,"NUMERICAL_mul32_out_product case=124 actual=%h expected=%h",mul32_out_product,64'hc000000080000000); end
125: begin if (mul32_out_product !== 64'hfffffffdc9257dff) $fatal(1,"NUMERICAL_mul32_out_product case=125 actual=%h expected=%h",mul32_out_product,64'hfffffffdc9257dff); end
126: begin if (mul32_out_product !== 64'hffffffffc98d012d) $fatal(1,"NUMERICAL_mul32_out_product case=126 actual=%h expected=%h",mul32_out_product,64'hffffffffc98d012d); end
127: begin if (mul32_out_product !== 64'h00000000643678a4) $fatal(1,"NUMERICAL_mul32_out_product case=127 actual=%h expected=%h",mul32_out_product,64'h00000000643678a4); end
128: begin if (mul32_out_product !== 64'h000000003537016e) $fatal(1,"NUMERICAL_mul32_out_product case=128 actual=%h expected=%h",mul32_out_product,64'h000000003537016e); end
129: begin if (mul32_out_product !== 64'h00000003155e6bca) $fatal(1,"NUMERICAL_mul32_out_product case=129 actual=%h expected=%h",mul32_out_product,64'h00000003155e6bca); end
130: begin if (mul32_out_product !== 64'hffffffffa9817051) $fatal(1,"NUMERICAL_mul32_out_product case=130 actual=%h expected=%h",mul32_out_product,64'hffffffffa9817051); end
131: begin if (mul32_out_product !== 64'hffffffffc9036451) $fatal(1,"NUMERICAL_mul32_out_product case=131 actual=%h expected=%h",mul32_out_product,64'hffffffffc9036451); end
132: begin if (mul32_out_product !== 64'h0000000000000000) $fatal(1,"NUMERICAL_mul32_out_product case=132 actual=%h expected=%h",mul32_out_product,64'h0000000000000000); end
133: begin if (mul32_out_product !== 64'h0000000309bea70a) $fatal(1,"NUMERICAL_mul32_out_product case=133 actual=%h expected=%h",mul32_out_product,64'h0000000309bea70a); end
134: begin if (mul32_out_product !== 64'hfffffffebe392c2c) $fatal(1,"NUMERICAL_mul32_out_product case=134 actual=%h expected=%h",mul32_out_product,64'hfffffffebe392c2c); end
135: begin if (mul32_out_product !== 64'h00000000554b30d4) $fatal(1,"NUMERICAL_mul32_out_product case=135 actual=%h expected=%h",mul32_out_product,64'h00000000554b30d4); end
136: begin if (mul32_out_product !== 64'h000000026ac4c226) $fatal(1,"NUMERICAL_mul32_out_product case=136 actual=%h expected=%h",mul32_out_product,64'h000000026ac4c226); end
137: begin if (mul32_out_product !== 64'hfffffffe6f9e7866) $fatal(1,"NUMERICAL_mul32_out_product case=137 actual=%h expected=%h",mul32_out_product,64'hfffffffe6f9e7866); end
138: begin if (mul32_out_product !== 64'h0000000223adfe50) $fatal(1,"NUMERICAL_mul32_out_product case=138 actual=%h expected=%h",mul32_out_product,64'h0000000223adfe50); end
139: begin if (mul32_out_product !== 64'h0000000102af7a78) $fatal(1,"NUMERICAL_mul32_out_product case=139 actual=%h expected=%h",mul32_out_product,64'h0000000102af7a78); end
140: begin if (mul32_out_product !== 64'h0000000277d71e90) $fatal(1,"NUMERICAL_mul32_out_product case=140 actual=%h expected=%h",mul32_out_product,64'h0000000277d71e90); end
141: begin if (mul32_out_product !== 64'hffffffff44be7c18) $fatal(1,"NUMERICAL_mul32_out_product case=141 actual=%h expected=%h",mul32_out_product,64'hffffffff44be7c18); end
142: begin if (mul32_out_product !== 64'hffffffffddd8ed11) $fatal(1,"NUMERICAL_mul32_out_product case=142 actual=%h expected=%h",mul32_out_product,64'hffffffffddd8ed11); end
143: begin if (mul32_out_product !== 64'h000000003bf5686f) $fatal(1,"NUMERICAL_mul32_out_product case=143 actual=%h expected=%h",mul32_out_product,64'h000000003bf5686f); end
144: begin if (mul32_out_product !== 64'hffffffffce146d2e) $fatal(1,"NUMERICAL_mul32_out_product case=144 actual=%h expected=%h",mul32_out_product,64'hffffffffce146d2e); end
145: begin if (mul32_out_product !== 64'h0000000012b58378) $fatal(1,"NUMERICAL_mul32_out_product case=145 actual=%h expected=%h",mul32_out_product,64'h0000000012b58378); end
146: begin if (mul32_out_product !== 64'hffffffff4e99864c) $fatal(1,"NUMERICAL_mul32_out_product case=146 actual=%h expected=%h",mul32_out_product,64'hffffffff4e99864c); end
147: begin if (mul32_out_product !== 64'h000000022a6cfa05) $fatal(1,"NUMERICAL_mul32_out_product case=147 actual=%h expected=%h",mul32_out_product,64'h000000022a6cfa05); end
148: begin if (mul32_out_product !== 64'hffffffffc6caa740) $fatal(1,"NUMERICAL_mul32_out_product case=148 actual=%h expected=%h",mul32_out_product,64'hffffffffc6caa740); end
149: begin if (mul32_out_product !== 64'h0000385fa85bbc7c) $fatal(1,"NUMERICAL_mul32_out_product case=149 actual=%h expected=%h",mul32_out_product,64'h0000385fa85bbc7c); end
150: begin if (mul32_out_product !== 64'hffffd2a03b499595) $fatal(1,"NUMERICAL_mul32_out_product case=150 actual=%h expected=%h",mul32_out_product,64'hffffd2a03b499595); end
151: begin if (mul32_out_product !== 64'h0000039c62206152) $fatal(1,"NUMERICAL_mul32_out_product case=151 actual=%h expected=%h",mul32_out_product,64'h0000039c62206152); end
152: begin if (mul32_out_product !== 64'hfffff16a347b78c7) $fatal(1,"NUMERICAL_mul32_out_product case=152 actual=%h expected=%h",mul32_out_product,64'hfffff16a347b78c7); end
153: begin if (mul32_out_product !== 64'hffffde1e190144b0) $fatal(1,"NUMERICAL_mul32_out_product case=153 actual=%h expected=%h",mul32_out_product,64'hffffde1e190144b0); end
154: begin if (mul32_out_product !== 64'h00000065a226887b) $fatal(1,"NUMERICAL_mul32_out_product case=154 actual=%h expected=%h",mul32_out_product,64'h00000065a226887b); end
155: begin if (mul32_out_product !== 64'h00000ab0f4d29e18) $fatal(1,"NUMERICAL_mul32_out_product case=155 actual=%h expected=%h",mul32_out_product,64'h00000ab0f4d29e18); end
156: begin if (mul32_out_product !== 64'hfffffe9480641ae9) $fatal(1,"NUMERICAL_mul32_out_product case=156 actual=%h expected=%h",mul32_out_product,64'hfffffe9480641ae9); end
157: begin if (mul32_out_product !== 64'hfffffd883cc30e42) $fatal(1,"NUMERICAL_mul32_out_product case=157 actual=%h expected=%h",mul32_out_product,64'hfffffd883cc30e42); end
158: begin if (mul32_out_product !== 64'hffffffdc4b18fef4) $fatal(1,"NUMERICAL_mul32_out_product case=158 actual=%h expected=%h",mul32_out_product,64'hffffffdc4b18fef4); end
159: begin if (mul32_out_product !== 64'hfffff812dde76124) $fatal(1,"NUMERICAL_mul32_out_product case=159 actual=%h expected=%h",mul32_out_product,64'hfffff812dde76124); end
160: begin if (mul32_out_product !== 64'h00001f0897fa2dd4) $fatal(1,"NUMERICAL_mul32_out_product case=160 actual=%h expected=%h",mul32_out_product,64'h00001f0897fa2dd4); end
161: begin if (mul32_out_product !== 64'h000000814b9b0544) $fatal(1,"NUMERICAL_mul32_out_product case=161 actual=%h expected=%h",mul32_out_product,64'h000000814b9b0544); end
162: begin if (mul32_out_product !== 64'h00001e79584f74ec) $fatal(1,"NUMERICAL_mul32_out_product case=162 actual=%h expected=%h",mul32_out_product,64'h00001e79584f74ec); end
163: begin if (mul32_out_product !== 64'hfffffd9b616bdc09) $fatal(1,"NUMERICAL_mul32_out_product case=163 actual=%h expected=%h",mul32_out_product,64'hfffffd9b616bdc09); end
164: begin if (mul32_out_product !== 64'hffffdf8662e38984) $fatal(1,"NUMERICAL_mul32_out_product case=164 actual=%h expected=%h",mul32_out_product,64'hffffdf8662e38984); end
165: begin if (mul32_out_product !== 64'hffffedfea7e695c3) $fatal(1,"NUMERICAL_mul32_out_product case=165 actual=%h expected=%h",mul32_out_product,64'hffffedfea7e695c3); end
166: begin if (mul32_out_product !== 64'hffffea1df5c6ebdc) $fatal(1,"NUMERICAL_mul32_out_product case=166 actual=%h expected=%h",mul32_out_product,64'hffffea1df5c6ebdc); end
167: begin if (mul32_out_product !== 64'h0000040aa21d93a0) $fatal(1,"NUMERICAL_mul32_out_product case=167 actual=%h expected=%h",mul32_out_product,64'h0000040aa21d93a0); end
168: begin if (mul32_out_product !== 64'h00001dc0885014df) $fatal(1,"NUMERICAL_mul32_out_product case=168 actual=%h expected=%h",mul32_out_product,64'h00001dc0885014df); end
169: begin if (mul32_out_product !== 64'hfffff0d47cf7ab71) $fatal(1,"NUMERICAL_mul32_out_product case=169 actual=%h expected=%h",mul32_out_product,64'hfffff0d47cf7ab71); end
170: begin if (mul32_out_product !== 64'hfffffb4580bbebee) $fatal(1,"NUMERICAL_mul32_out_product case=170 actual=%h expected=%h",mul32_out_product,64'hfffffb4580bbebee); end
171: begin if (mul32_out_product !== 64'hfffff45b9f14715e) $fatal(1,"NUMERICAL_mul32_out_product case=171 actual=%h expected=%h",mul32_out_product,64'hfffff45b9f14715e); end
172: begin if (mul32_out_product !== 64'h00000b3968d3e746) $fatal(1,"NUMERICAL_mul32_out_product case=172 actual=%h expected=%h",mul32_out_product,64'h00000b3968d3e746); end
173: begin if (mul32_out_product !== 64'h000000012f803803) $fatal(1,"NUMERICAL_mul32_out_product case=173 actual=%h expected=%h",mul32_out_product,64'h000000012f803803); end
174: begin if (mul32_out_product !== 64'h0000000017d57df8) $fatal(1,"NUMERICAL_mul32_out_product case=174 actual=%h expected=%h",mul32_out_product,64'h0000000017d57df8); end
175: begin if (mul32_out_product !== 64'hffffffffc5d900d5) $fatal(1,"NUMERICAL_mul32_out_product case=175 actual=%h expected=%h",mul32_out_product,64'hffffffffc5d900d5); end
176: begin if (mul32_out_product !== 64'hfffffffdeb69fdaf) $fatal(1,"NUMERICAL_mul32_out_product case=176 actual=%h expected=%h",mul32_out_product,64'hfffffffdeb69fdaf); end
177: begin if (mul32_out_product !== 64'hffffffffff8deeb6) $fatal(1,"NUMERICAL_mul32_out_product case=177 actual=%h expected=%h",mul32_out_product,64'hffffffffff8deeb6); end
178: begin if (mul32_out_product !== 64'hffffffff816b0570) $fatal(1,"NUMERICAL_mul32_out_product case=178 actual=%h expected=%h",mul32_out_product,64'hffffffff816b0570); end
179: begin if (mul32_out_product !== 64'hfffffffe5a3c389b) $fatal(1,"NUMERICAL_mul32_out_product case=179 actual=%h expected=%h",mul32_out_product,64'hfffffffe5a3c389b); end
180: begin if (mul32_out_product !== 64'hffffffffccddf8ee) $fatal(1,"NUMERICAL_mul32_out_product case=180 actual=%h expected=%h",mul32_out_product,64'hffffffffccddf8ee); end
181: begin if (mul32_out_product !== 64'h00000002203233c8) $fatal(1,"NUMERICAL_mul32_out_product case=181 actual=%h expected=%h",mul32_out_product,64'h00000002203233c8); end
182: begin if (mul32_out_product !== 64'h0000000071749cb2) $fatal(1,"NUMERICAL_mul32_out_product case=182 actual=%h expected=%h",mul32_out_product,64'h0000000071749cb2); end
183: begin if (mul32_out_product !== 64'hfffffffe020c296d) $fatal(1,"NUMERICAL_mul32_out_product case=183 actual=%h expected=%h",mul32_out_product,64'hfffffffe020c296d); end
184: begin if (mul32_out_product !== 64'h000000008856ef5c) $fatal(1,"NUMERICAL_mul32_out_product case=184 actual=%h expected=%h",mul32_out_product,64'h000000008856ef5c); end
185: begin if (mul32_out_product !== 64'hffffffff78e77d50) $fatal(1,"NUMERICAL_mul32_out_product case=185 actual=%h expected=%h",mul32_out_product,64'hffffffff78e77d50); end
186: begin if (mul32_out_product !== 64'hffffffff546a7180) $fatal(1,"NUMERICAL_mul32_out_product case=186 actual=%h expected=%h",mul32_out_product,64'hffffffff546a7180); end
187: begin if (mul32_out_product !== 64'h000000020a0adb42) $fatal(1,"NUMERICAL_mul32_out_product case=187 actual=%h expected=%h",mul32_out_product,64'h000000020a0adb42); end
188: begin if (mul32_out_product !== 64'hfffffffe21af2600) $fatal(1,"NUMERICAL_mul32_out_product case=188 actual=%h expected=%h",mul32_out_product,64'hfffffffe21af2600); end
189: begin if (mul32_out_product !== 64'h00000000a5c97ed0) $fatal(1,"NUMERICAL_mul32_out_product case=189 actual=%h expected=%h",mul32_out_product,64'h00000000a5c97ed0); end
190: begin if (mul32_out_product !== 64'hffffffff2630e795) $fatal(1,"NUMERICAL_mul32_out_product case=190 actual=%h expected=%h",mul32_out_product,64'hffffffff2630e795); end
191: begin if (mul32_out_product !== 64'hffffffffdf6fcafe) $fatal(1,"NUMERICAL_mul32_out_product case=191 actual=%h expected=%h",mul32_out_product,64'hffffffffdf6fcafe); end
192: begin if (mul32_out_product !== 64'hffffffff14d8daa4) $fatal(1,"NUMERICAL_mul32_out_product case=192 actual=%h expected=%h",mul32_out_product,64'hffffffff14d8daa4); end
193: begin if (mul32_out_product !== 64'hffffffffd0cb3115) $fatal(1,"NUMERICAL_mul32_out_product case=193 actual=%h expected=%h",mul32_out_product,64'hffffffffd0cb3115); end
194: begin if (mul32_out_product !== 64'hffffffff0319e838) $fatal(1,"NUMERICAL_mul32_out_product case=194 actual=%h expected=%h",mul32_out_product,64'hffffffff0319e838); end
195: begin if (mul32_out_product !== 64'hfffffffe05ae76d7) $fatal(1,"NUMERICAL_mul32_out_product case=195 actual=%h expected=%h",mul32_out_product,64'hfffffffe05ae76d7); end
196: begin if (mul32_out_product !== 64'h000000004aba05a4) $fatal(1,"NUMERICAL_mul32_out_product case=196 actual=%h expected=%h",mul32_out_product,64'h000000004aba05a4); end
endcase
held={1'b1,{mul32_out_product}};
@(negedge clk); mul32_iv=0;
repeat(3) begin @(posedge clk);
if ({mul32_ov,{mul32_out_product}} !== held) $fatal(1,"STALLED_mul32");
#1;
if ({mul32_ov,{mul32_out_product}} !== held) $fatal(1,"STALLED_POST_mul32");
end
@(negedge clk); mul32_or=1; @(posedge clk); #1;
if (mul32_ov !== 1'b0) $fatal(1,"RETIRE_mul32");
@(negedge clk); mul32_or=0;
comparisons=comparisons+1;
end endtask
task automatic run_mul96(input integer index);
reg [128:0] held;
integer elapsed;
begin
@(negedge clk);
while (mul96_ir !== 1'b1) @(negedge clk);
case(index)
0: begin mul96_in_a=96'h800000000000000000000000; mul96_in_b=32'h80000000; end
1: begin mul96_in_a=96'h800000000000000000000000; mul96_in_b=32'hffffffff; end
2: begin mul96_in_a=96'h800000000000000000000000; mul96_in_b=32'h00000001; end
3: begin mul96_in_a=96'h800000000000000000000000; mul96_in_b=32'h7fffffff; end
4: begin mul96_in_a=96'h7fffffffffffffffffffffff; mul96_in_b=32'h80000000; end
5: begin mul96_in_a=96'h7fffffffffffffffffffffff; mul96_in_b=32'hffffffff; end
6: begin mul96_in_a=96'h7fffffffffffffffffffffff; mul96_in_b=32'h00000001; end
7: begin mul96_in_a=96'h7fffffffffffffffffffffff; mul96_in_b=32'h7fffffff; end
8: begin mul96_in_a=96'hffffffffffffffffffffffff; mul96_in_b=32'h80000000; end
9: begin mul96_in_a=96'hffffffffffffffffffffffff; mul96_in_b=32'hffffffff; end
10: begin mul96_in_a=96'hffffffffffffffffffffffff; mul96_in_b=32'h00000001; end
11: begin mul96_in_a=96'hffffffffffffffffffffffff; mul96_in_b=32'h7fffffff; end
12: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h80000000; end
13: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hffffffff; end
14: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000001; end
15: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h7fffffff; end
16: begin mul96_in_a=96'h000000008000000080000000; mul96_in_b=32'h80000000; end
17: begin mul96_in_a=96'h000000008000000080000000; mul96_in_b=32'hffffffff; end
18: begin mul96_in_a=96'h000000008000000080000000; mul96_in_b=32'h00000001; end
19: begin mul96_in_a=96'h000000008000000080000000; mul96_in_b=32'h7fffffff; end
20: begin mul96_in_a=96'hffffffff7fffffff80000000; mul96_in_b=32'h80000000; end
21: begin mul96_in_a=96'hffffffff7fffffff80000000; mul96_in_b=32'hffffffff; end
22: begin mul96_in_a=96'hffffffff7fffffff80000000; mul96_in_b=32'h00000001; end
23: begin mul96_in_a=96'hffffffff7fffffff80000000; mul96_in_b=32'h7fffffff; end
24: begin mul96_in_a=96'h148e75a139d85b407a2cebe9; mul96_in_b=32'h00000000; end
25: begin mul96_in_a=96'h5db712149ad884785d8fd01d; mul96_in_b=32'hffffffff; end
26: begin mul96_in_a=96'habf525ab21744d1d2282e0b5; mul96_in_b=32'h80000000; end
27: begin mul96_in_a=96'h024a61152fe15e96c261ea9e; mul96_in_b=32'h7fffffff; end
28: begin mul96_in_a=96'h63cc1af447bfd3d121e0a404; mul96_in_b=32'h7fffffff; end
29: begin mul96_in_a=96'h2d2bf4ff2c890585959d10d3; mul96_in_b=32'h57946374; end
30: begin mul96_in_a=96'h1ce296460fe3b49a1ca42d0a; mul96_in_b=32'h53fa9e5e; end
31: begin mul96_in_a=96'h7e252ae22b13ba4e91d9c1d7; mul96_in_b=32'h3927cc6b; end
32: begin mul96_in_a=96'hb15c6292001a47a5ee899310; mul96_in_b=32'h65d65714; end
33: begin mul96_in_a=96'hb84c092e3ff7e923ce49d580; mul96_in_b=32'he1e80913; end
34: begin mul96_in_a=96'hf3313c09e0bff56208f0199a; mul96_in_b=32'h3ff6876f; end
35: begin mul96_in_a=96'h3a44c23067e4a792135237d5; mul96_in_b=32'h186fb230; end
36: begin mul96_in_a=96'h83453a8c3e5b567b07584643; mul96_in_b=32'h19975f63; end
37: begin mul96_in_a=96'hcc841126bb7f0f5ee879acdf; mul96_in_b=32'h5468bb88; end
38: begin mul96_in_a=96'haeb1555469e5caaf6b79120a; mul96_in_b=32'hba8594eb; end
39: begin mul96_in_a=96'hda0f9869bbf96c5d2205a1d3; mul96_in_b=32'h4a134c1c; end
40: begin mul96_in_a=96'h00ffdbe4f878920315562b3c; mul96_in_b=32'hb720d6b8; end
41: begin mul96_in_a=96'h7978a19da9a8de099c87cff6; mul96_in_b=32'h012bab3f; end
42: begin mul96_in_a=96'h98064d3315dd03d5140bb544; mul96_in_b=32'h72432c08; end
43: begin mul96_in_a=96'ha7efd64ab56874889b52975b; mul96_in_b=32'h7dd2d03d; end
44: begin mul96_in_a=96'h1655849c7dc2cad127187b23; mul96_in_b=32'h7c74916e; end
45: begin mul96_in_a=96'h8cf5dacb1a09b622933b3855; mul96_in_b=32'h313e63c4; end
46: begin mul96_in_a=96'hfc22194f2a060ef104aeb2ca; mul96_in_b=32'he1c58629; end
47: begin mul96_in_a=96'hd75ce040d8835730581adcbc; mul96_in_b=32'hf100eb21; end
48: begin mul96_in_a=96'hc14c73ad5e1c325fdd93b448; mul96_in_b=32'h4b59da8e; end
49: begin mul96_in_a=96'hbbae72f5834901a285d2ed31; mul96_in_b=32'haaedabf7; end
50: begin mul96_in_a=96'h821db5853d4e59a32d953d48; mul96_in_b=32'h09918c4d; end
51: begin mul96_in_a=96'hc123103e127d0b3105755144; mul96_in_b=32'hbd9777a7; end
52: begin mul96_in_a=96'h6b0445cc695cd352215ab7ae; mul96_in_b=32'h79334ee3; end
53: begin mul96_in_a=96'h49b8a5a8e6a2446115fa83be; mul96_in_b=32'h70b8e5a4; end
54: begin mul96_in_a=96'h9bc886ee6f854fdb65d4160d; mul96_in_b=32'h94011741; end
55: begin mul96_in_a=96'h5dfa944528a5bf61bc2ab8c7; mul96_in_b=32'h0d8b2a04; end
56: begin mul96_in_a=96'h5ed806b03da07f717c8c467a; mul96_in_b=32'h244ad34d; end
57: begin mul96_in_a=96'h2a29bfbfc4ec6f85d333d952; mul96_in_b=32'hdf13f7f8; end
58: begin mul96_in_a=96'h1f54d8206931417cbac3f100; mul96_in_b=32'hc093c759; end
59: begin mul96_in_a=96'h9be647609b68d958595ed7b1; mul96_in_b=32'had873e00; end
60: begin mul96_in_a=96'h9b5d00497d4ef3a9ad7e43bf; mul96_in_b=32'h96a5de21; end
61: begin mul96_in_a=96'hf3aca8670367f64edbfcaabb; mul96_in_b=32'hc9858631; end
62: begin mul96_in_a=96'h1e53e374c5f02fd5503012d6; mul96_in_b=32'h9d79494b; end
63: begin mul96_in_a=96'h52164f6c84f148358c59ad98; mul96_in_b=32'hecf2ff46; end
64: begin mul96_in_a=96'h1433df6b1af062c72f385e90; mul96_in_b=32'h6204d52e; end
65: begin mul96_in_a=96'h4f408568c42871711e32e080; mul96_in_b=32'h44431924; end
66: begin mul96_in_a=96'h9edb8999ff1fa75b972a96f4; mul96_in_b=32'hec371e26; end
67: begin mul96_in_a=96'hc4c89f89ffdc5be67effb373; mul96_in_b=32'hd2d38d49; end
68: begin mul96_in_a=96'hf57b229cc6033abaf94ce88a; mul96_in_b=32'ha50e3944; end
69: begin mul96_in_a=96'hc33c2c868c36164d261ee9e7; mul96_in_b=32'hf36f0424; end
70: begin mul96_in_a=96'h15ae53bb94d610586277965d; mul96_in_b=32'h5c32cde0; end
71: begin mul96_in_a=96'he86b4e286cd9cdd682169b38; mul96_in_b=32'he101f29b; end
72: begin mul96_in_a=96'h18730b23272314df16afe353; mul96_in_b=32'h01070cc1; end
73: begin mul96_in_a=96'h62589b42a79dd472075f6a04; mul96_in_b=32'h38e4bda2; end
74: begin mul96_in_a=96'hf9a4d4b17f661ef8925ed0a5; mul96_in_b=32'hc4e631f0; end
75: begin mul96_in_a=96'hf02127ea4f78377dc1786629; mul96_in_b=32'h014deac9; end
76: begin mul96_in_a=96'h1139ce7336eb48bcc11b0b87; mul96_in_b=32'hf36cf615; end
77: begin mul96_in_a=96'h000000000000000000010000; mul96_in_b=32'hfffb0000; end
78: begin mul96_in_a=96'h000000000000000000010000; mul96_in_b=32'h000000ff; end
79: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
80: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
81: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
82: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
83: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
84: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
85: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
86: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
87: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
88: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
89: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
90: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
91: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
92: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
93: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
94: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
95: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
96: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
97: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
98: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
99: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
100: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
101: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
102: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
103: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
104: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
105: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
106: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
107: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
108: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
109: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
110: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
111: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
112: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
113: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
114: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
115: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
116: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
117: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
118: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
119: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
120: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
121: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
122: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
123: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hfffb0000; end
124: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
125: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
126: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
127: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
128: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
129: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
130: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
131: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
132: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
133: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
134: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
135: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
136: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
137: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
138: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
139: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
140: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
141: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
142: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
143: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
144: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
145: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
146: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
147: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
148: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
149: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
150: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
151: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
152: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
153: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
154: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
155: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
156: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
157: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
158: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
159: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
160: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
161: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
162: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
163: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
164: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
165: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
166: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
167: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
168: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
169: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
170: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
171: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000000; end
172: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h00000100; end
173: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
174: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
175: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
176: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
177: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
178: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
179: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
180: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
181: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
182: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
183: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
184: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
185: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
186: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
187: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
188: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
189: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
190: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
191: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
192: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
193: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
194: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
195: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
196: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
197: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
198: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
199: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
200: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
201: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
202: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
203: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
204: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
205: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
206: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
207: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
208: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
209: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
210: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
211: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
212: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
213: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
214: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
215: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
216: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
217: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
218: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
219: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00020000; end
220: begin mul96_in_a=96'hffffffffc000000080000000; mul96_in_b=32'h00000000; end
221: begin mul96_in_a=96'hfffffffffffffffdc9257dff; mul96_in_b=32'hd6aaad84; end
222: begin mul96_in_a=96'hfffffffffffffffdc9257dff; mul96_in_b=32'h000000ff; end
223: begin mul96_in_a=96'hffffffffffffffffc98d012d; mul96_in_b=32'hd6aaad84; end
224: begin mul96_in_a=96'hffffffffffffffffc98d012d; mul96_in_b=32'h000000ff; end
225: begin mul96_in_a=96'h0000000000000000643678a4; mul96_in_b=32'hd6aaad84; end
226: begin mul96_in_a=96'h0000000000000000643678a4; mul96_in_b=32'h000000ff; end
227: begin mul96_in_a=96'h00000000000000003537016e; mul96_in_b=32'hd6aaad84; end
228: begin mul96_in_a=96'h00000000000000003537016e; mul96_in_b=32'h000000ff; end
229: begin mul96_in_a=96'h0000000000000003155e6bca; mul96_in_b=32'hd6aaad84; end
230: begin mul96_in_a=96'h0000000000000003155e6bca; mul96_in_b=32'h000000ff; end
231: begin mul96_in_a=96'hffffffffffffffffa9817051; mul96_in_b=32'hd6aaad84; end
232: begin mul96_in_a=96'hffffffffffffffffa9817051; mul96_in_b=32'h000000ff; end
233: begin mul96_in_a=96'hffffffffffffffffc9036451; mul96_in_b=32'hd6aaad84; end
234: begin mul96_in_a=96'hffffffffffffffffc9036451; mul96_in_b=32'h000000ff; end
235: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'hd6aaad84; end
236: begin mul96_in_a=96'h000000000000000000000000; mul96_in_b=32'h000000ff; end
237: begin mul96_in_a=96'h000000000000000309bea70a; mul96_in_b=32'hd6aaad84; end
238: begin mul96_in_a=96'h000000000000000309bea70a; mul96_in_b=32'h000000ff; end
239: begin mul96_in_a=96'hfffffffffffffffebe392c2c; mul96_in_b=32'hd6aaad84; end
240: begin mul96_in_a=96'hfffffffffffffffebe392c2c; mul96_in_b=32'h000000ff; end
241: begin mul96_in_a=96'h0000000000000000554b30d4; mul96_in_b=32'hd6aaad84; end
242: begin mul96_in_a=96'h0000000000000000554b30d4; mul96_in_b=32'h000000ff; end
243: begin mul96_in_a=96'h00000000000000026ac4c226; mul96_in_b=32'hd6aaad84; end
244: begin mul96_in_a=96'h00000000000000026ac4c226; mul96_in_b=32'h000000ff; end
245: begin mul96_in_a=96'hfffffffffffffffe6f9e7866; mul96_in_b=32'hd6aaad84; end
246: begin mul96_in_a=96'hfffffffffffffffe6f9e7866; mul96_in_b=32'h000000ff; end
247: begin mul96_in_a=96'h000000000000000223adfe50; mul96_in_b=32'hd6aaad84; end
248: begin mul96_in_a=96'h000000000000000223adfe50; mul96_in_b=32'h000000ff; end
249: begin mul96_in_a=96'h000000000000000102af7a78; mul96_in_b=32'hd6aaad84; end
250: begin mul96_in_a=96'h000000000000000102af7a78; mul96_in_b=32'h000000ff; end
251: begin mul96_in_a=96'h000000000000000277d71e90; mul96_in_b=32'hd6aaad84; end
252: begin mul96_in_a=96'h000000000000000277d71e90; mul96_in_b=32'h000000ff; end
253: begin mul96_in_a=96'hffffffffffffffff44be7c18; mul96_in_b=32'hd6aaad84; end
254: begin mul96_in_a=96'hffffffffffffffff44be7c18; mul96_in_b=32'h000000ff; end
255: begin mul96_in_a=96'hffffffffffffffffddd8ed11; mul96_in_b=32'hd6aaad84; end
256: begin mul96_in_a=96'hffffffffffffffffddd8ed11; mul96_in_b=32'h000000ff; end
257: begin mul96_in_a=96'h00000000000000003bf5686f; mul96_in_b=32'hd6aaad84; end
258: begin mul96_in_a=96'h00000000000000003bf5686f; mul96_in_b=32'h000000ff; end
259: begin mul96_in_a=96'hffffffffffffffffce146d2e; mul96_in_b=32'hd6aaad84; end
260: begin mul96_in_a=96'hffffffffffffffffce146d2e; mul96_in_b=32'h000000ff; end
261: begin mul96_in_a=96'h000000000000000012b58378; mul96_in_b=32'hd6aaad84; end
262: begin mul96_in_a=96'h000000000000000012b58378; mul96_in_b=32'h000000ff; end
263: begin mul96_in_a=96'hffffffffffffffff4e99864c; mul96_in_b=32'hd6aaad84; end
264: begin mul96_in_a=96'hffffffffffffffff4e99864c; mul96_in_b=32'h000000ff; end
265: begin mul96_in_a=96'h00000000000000022a6cfa05; mul96_in_b=32'hd6aaad84; end
266: begin mul96_in_a=96'h00000000000000022a6cfa05; mul96_in_b=32'h000000ff; end
267: begin mul96_in_a=96'hffffffffffffffffc6caa740; mul96_in_b=32'hd6aaad84; end
268: begin mul96_in_a=96'hffffffffffffffffc6caa740; mul96_in_b=32'h000000ff; end
269: begin mul96_in_a=96'h000000000000385fa85bbc7c; mul96_in_b=32'ha3d99c1e; end
270: begin mul96_in_a=96'h000000000000385fa85bbc7c; mul96_in_b=32'h00000001; end
271: begin mul96_in_a=96'hffffffffffffd2a03b499595; mul96_in_b=32'ha3d99c1e; end
272: begin mul96_in_a=96'hffffffffffffd2a03b499595; mul96_in_b=32'h00000001; end
273: begin mul96_in_a=96'h000000000000039c62206152; mul96_in_b=32'ha3d99c1e; end
274: begin mul96_in_a=96'h000000000000039c62206152; mul96_in_b=32'h00000001; end
275: begin mul96_in_a=96'hfffffffffffff16a347b78c7; mul96_in_b=32'ha3d99c1e; end
276: begin mul96_in_a=96'hfffffffffffff16a347b78c7; mul96_in_b=32'h00000001; end
277: begin mul96_in_a=96'hffffffffffffde1e190144b0; mul96_in_b=32'ha3d99c1e; end
278: begin mul96_in_a=96'hffffffffffffde1e190144b0; mul96_in_b=32'h00000001; end
279: begin mul96_in_a=96'h0000000000000065a226887b; mul96_in_b=32'ha3d99c1e; end
280: begin mul96_in_a=96'h0000000000000065a226887b; mul96_in_b=32'h00000001; end
281: begin mul96_in_a=96'h0000000000000ab0f4d29e18; mul96_in_b=32'ha3d99c1e; end
282: begin mul96_in_a=96'h0000000000000ab0f4d29e18; mul96_in_b=32'h00000001; end
283: begin mul96_in_a=96'hfffffffffffffe9480641ae9; mul96_in_b=32'ha3d99c1e; end
284: begin mul96_in_a=96'hfffffffffffffe9480641ae9; mul96_in_b=32'h00000001; end
285: begin mul96_in_a=96'hfffffffffffffd883cc30e42; mul96_in_b=32'ha3d99c1e; end
286: begin mul96_in_a=96'hfffffffffffffd883cc30e42; mul96_in_b=32'h00000001; end
287: begin mul96_in_a=96'hffffffffffffffdc4b18fef4; mul96_in_b=32'ha3d99c1e; end
288: begin mul96_in_a=96'hffffffffffffffdc4b18fef4; mul96_in_b=32'h00000001; end
289: begin mul96_in_a=96'hfffffffffffff812dde76124; mul96_in_b=32'ha3d99c1e; end
290: begin mul96_in_a=96'hfffffffffffff812dde76124; mul96_in_b=32'h00000001; end
291: begin mul96_in_a=96'h0000000000001f0897fa2dd4; mul96_in_b=32'ha3d99c1e; end
292: begin mul96_in_a=96'h0000000000001f0897fa2dd4; mul96_in_b=32'h00000001; end
293: begin mul96_in_a=96'h00000000000000814b9b0544; mul96_in_b=32'ha3d99c1e; end
294: begin mul96_in_a=96'h00000000000000814b9b0544; mul96_in_b=32'h00000001; end
295: begin mul96_in_a=96'h0000000000001e79584f74ec; mul96_in_b=32'ha3d99c1e; end
296: begin mul96_in_a=96'h0000000000001e79584f74ec; mul96_in_b=32'h00000001; end
297: begin mul96_in_a=96'hfffffffffffffd9b616bdc09; mul96_in_b=32'ha3d99c1e; end
298: begin mul96_in_a=96'hfffffffffffffd9b616bdc09; mul96_in_b=32'h00000001; end
299: begin mul96_in_a=96'hffffffffffffdf8662e38984; mul96_in_b=32'ha3d99c1e; end
300: begin mul96_in_a=96'hffffffffffffdf8662e38984; mul96_in_b=32'h00000001; end
301: begin mul96_in_a=96'hffffffffffffedfea7e695c3; mul96_in_b=32'ha3d99c1e; end
302: begin mul96_in_a=96'hffffffffffffedfea7e695c3; mul96_in_b=32'h00000001; end
303: begin mul96_in_a=96'hffffffffffffea1df5c6ebdc; mul96_in_b=32'ha3d99c1e; end
304: begin mul96_in_a=96'hffffffffffffea1df5c6ebdc; mul96_in_b=32'h00000001; end
305: begin mul96_in_a=96'h000000000000040aa21d93a0; mul96_in_b=32'ha3d99c1e; end
306: begin mul96_in_a=96'h000000000000040aa21d93a0; mul96_in_b=32'h00000001; end
307: begin mul96_in_a=96'h0000000000001dc0885014df; mul96_in_b=32'ha3d99c1e; end
308: begin mul96_in_a=96'h0000000000001dc0885014df; mul96_in_b=32'h00000001; end
309: begin mul96_in_a=96'hfffffffffffff0d47cf7ab71; mul96_in_b=32'ha3d99c1e; end
310: begin mul96_in_a=96'hfffffffffffff0d47cf7ab71; mul96_in_b=32'h00000001; end
311: begin mul96_in_a=96'hfffffffffffffb4580bbebee; mul96_in_b=32'ha3d99c1e; end
312: begin mul96_in_a=96'hfffffffffffffb4580bbebee; mul96_in_b=32'h00000001; end
313: begin mul96_in_a=96'hfffffffffffff45b9f14715e; mul96_in_b=32'ha3d99c1e; end
314: begin mul96_in_a=96'hfffffffffffff45b9f14715e; mul96_in_b=32'h00000001; end
315: begin mul96_in_a=96'h0000000000000b3968d3e746; mul96_in_b=32'ha3d99c1e; end
316: begin mul96_in_a=96'h0000000000000b3968d3e746; mul96_in_b=32'h00000001; end
317: begin mul96_in_a=96'h00000000000000012f803803; mul96_in_b=32'hd1a2674a; end
318: begin mul96_in_a=96'h00000000000000012f803803; mul96_in_b=32'h000000ff; end
319: begin mul96_in_a=96'h000000000000000017d57df8; mul96_in_b=32'hd1a2674a; end
320: begin mul96_in_a=96'h000000000000000017d57df8; mul96_in_b=32'h000000ff; end
321: begin mul96_in_a=96'hffffffffffffffffc5d900d5; mul96_in_b=32'hd1a2674a; end
322: begin mul96_in_a=96'hffffffffffffffffc5d900d5; mul96_in_b=32'h000000ff; end
323: begin mul96_in_a=96'hfffffffffffffffdeb69fdaf; mul96_in_b=32'hd1a2674a; end
324: begin mul96_in_a=96'hfffffffffffffffdeb69fdaf; mul96_in_b=32'h000000ff; end
325: begin mul96_in_a=96'hffffffffffffffffff8deeb6; mul96_in_b=32'hd1a2674a; end
326: begin mul96_in_a=96'hffffffffffffffffff8deeb6; mul96_in_b=32'h000000ff; end
327: begin mul96_in_a=96'hffffffffffffffff816b0570; mul96_in_b=32'hd1a2674a; end
328: begin mul96_in_a=96'hffffffffffffffff816b0570; mul96_in_b=32'h000000ff; end
329: begin mul96_in_a=96'hfffffffffffffffe5a3c389b; mul96_in_b=32'hd1a2674a; end
330: begin mul96_in_a=96'hfffffffffffffffe5a3c389b; mul96_in_b=32'h000000ff; end
331: begin mul96_in_a=96'hffffffffffffffffccddf8ee; mul96_in_b=32'hd1a2674a; end
332: begin mul96_in_a=96'hffffffffffffffffccddf8ee; mul96_in_b=32'h000000ff; end
333: begin mul96_in_a=96'h0000000000000002203233c8; mul96_in_b=32'hd1a2674a; end
334: begin mul96_in_a=96'h0000000000000002203233c8; mul96_in_b=32'h000000ff; end
335: begin mul96_in_a=96'h000000000000000071749cb2; mul96_in_b=32'hd1a2674a; end
336: begin mul96_in_a=96'h000000000000000071749cb2; mul96_in_b=32'h000000ff; end
337: begin mul96_in_a=96'hfffffffffffffffe020c296d; mul96_in_b=32'hd1a2674a; end
338: begin mul96_in_a=96'hfffffffffffffffe020c296d; mul96_in_b=32'h000000ff; end
339: begin mul96_in_a=96'h00000000000000008856ef5c; mul96_in_b=32'hd1a2674a; end
340: begin mul96_in_a=96'h00000000000000008856ef5c; mul96_in_b=32'h000000ff; end
341: begin mul96_in_a=96'hffffffffffffffff78e77d50; mul96_in_b=32'hd1a2674a; end
342: begin mul96_in_a=96'hffffffffffffffff78e77d50; mul96_in_b=32'h000000ff; end
343: begin mul96_in_a=96'hffffffffffffffff546a7180; mul96_in_b=32'hd1a2674a; end
344: begin mul96_in_a=96'hffffffffffffffff546a7180; mul96_in_b=32'h000000ff; end
345: begin mul96_in_a=96'h00000000000000020a0adb42; mul96_in_b=32'hd1a2674a; end
346: begin mul96_in_a=96'h00000000000000020a0adb42; mul96_in_b=32'h000000ff; end
347: begin mul96_in_a=96'hfffffffffffffffe21af2600; mul96_in_b=32'hd1a2674a; end
348: begin mul96_in_a=96'hfffffffffffffffe21af2600; mul96_in_b=32'h000000ff; end
349: begin mul96_in_a=96'h0000000000000000a5c97ed0; mul96_in_b=32'hd1a2674a; end
350: begin mul96_in_a=96'h0000000000000000a5c97ed0; mul96_in_b=32'h000000ff; end
351: begin mul96_in_a=96'hffffffffffffffff2630e795; mul96_in_b=32'hd1a2674a; end
352: begin mul96_in_a=96'hffffffffffffffff2630e795; mul96_in_b=32'h000000ff; end
353: begin mul96_in_a=96'hffffffffffffffffdf6fcafe; mul96_in_b=32'hd1a2674a; end
354: begin mul96_in_a=96'hffffffffffffffffdf6fcafe; mul96_in_b=32'h000000ff; end
355: begin mul96_in_a=96'hffffffffffffffff14d8daa4; mul96_in_b=32'hd1a2674a; end
356: begin mul96_in_a=96'hffffffffffffffff14d8daa4; mul96_in_b=32'h000000ff; end
357: begin mul96_in_a=96'hffffffffffffffffd0cb3115; mul96_in_b=32'hd1a2674a; end
358: begin mul96_in_a=96'hffffffffffffffffd0cb3115; mul96_in_b=32'h000000ff; end
359: begin mul96_in_a=96'hffffffffffffffff0319e838; mul96_in_b=32'hd1a2674a; end
360: begin mul96_in_a=96'hffffffffffffffff0319e838; mul96_in_b=32'h000000ff; end
361: begin mul96_in_a=96'hfffffffffffffffe05ae76d7; mul96_in_b=32'hd1a2674a; end
362: begin mul96_in_a=96'hfffffffffffffffe05ae76d7; mul96_in_b=32'h000000ff; end
363: begin mul96_in_a=96'h00000000000000004aba05a4; mul96_in_b=32'hd1a2674a; end
364: begin mul96_in_a=96'h00000000000000004aba05a4; mul96_in_b=32'h000000ff; end
default: $fatal(1,"BAD_CASE");
endcase
mul96_iv=1; @(posedge clk);
if (mul96_ir !== 1'b1) $fatal(1,"ACCEPT_mul96");
#1; elapsed=0;
repeat (7) begin
if (mul96_ov !== 1'b0) $fatal(1,"EARLY_VALID_mul96 edge=%0d",elapsed);
@(negedge clk); mul96_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
if (mul96_ov !== 1'b1) $fatal(1,"LATE_VALID_mul96 edge=%0d",elapsed);
case(index)
0: begin if (mul96_out_product !== 128'h40000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=0 actual=%h expected=%h",mul96_out_product,128'h40000000000000000000000000000000); end
1: begin if (mul96_out_product !== 128'h00000000800000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=1 actual=%h expected=%h",mul96_out_product,128'h00000000800000000000000000000000); end
2: begin if (mul96_out_product !== 128'hffffffff800000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=2 actual=%h expected=%h",mul96_out_product,128'hffffffff800000000000000000000000); end
3: begin if (mul96_out_product !== 128'hc0000000800000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=3 actual=%h expected=%h",mul96_out_product,128'hc0000000800000000000000000000000); end
4: begin if (mul96_out_product !== 128'hc0000000000000000000000080000000) $fatal(1,"NUMERICAL_mul96_out_product case=4 actual=%h expected=%h",mul96_out_product,128'hc0000000000000000000000080000000); end
5: begin if (mul96_out_product !== 128'hffffffff800000000000000000000001) $fatal(1,"NUMERICAL_mul96_out_product case=5 actual=%h expected=%h",mul96_out_product,128'hffffffff800000000000000000000001); end
6: begin if (mul96_out_product !== 128'h000000007fffffffffffffffffffffff) $fatal(1,"NUMERICAL_mul96_out_product case=6 actual=%h expected=%h",mul96_out_product,128'h000000007fffffffffffffffffffffff); end
7: begin if (mul96_out_product !== 128'h3fffffff7fffffffffffffff80000001) $fatal(1,"NUMERICAL_mul96_out_product case=7 actual=%h expected=%h",mul96_out_product,128'h3fffffff7fffffffffffffff80000001); end
8: begin if (mul96_out_product !== 128'h00000000000000000000000080000000) $fatal(1,"NUMERICAL_mul96_out_product case=8 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000080000000); end
9: begin if (mul96_out_product !== 128'h00000000000000000000000000000001) $fatal(1,"NUMERICAL_mul96_out_product case=9 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000001); end
10: begin if (mul96_out_product !== 128'hffffffffffffffffffffffffffffffff) $fatal(1,"NUMERICAL_mul96_out_product case=10 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffffffffffffff); end
11: begin if (mul96_out_product !== 128'hffffffffffffffffffffffff80000001) $fatal(1,"NUMERICAL_mul96_out_product case=11 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffffff80000001); end
12: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=12 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
13: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=13 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
14: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=14 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
15: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=15 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
16: begin if (mul96_out_product !== 128'hffffffffbfffffffc000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=16 actual=%h expected=%h",mul96_out_product,128'hffffffffbfffffffc000000000000000); end
17: begin if (mul96_out_product !== 128'hffffffffffffffff7fffffff80000000) $fatal(1,"NUMERICAL_mul96_out_product case=17 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffff7fffffff80000000); end
18: begin if (mul96_out_product !== 128'h00000000000000008000000080000000) $fatal(1,"NUMERICAL_mul96_out_product case=18 actual=%h expected=%h",mul96_out_product,128'h00000000000000008000000080000000); end
19: begin if (mul96_out_product !== 128'h000000003fffffffbfffffff80000000) $fatal(1,"NUMERICAL_mul96_out_product case=19 actual=%h expected=%h",mul96_out_product,128'h000000003fffffffbfffffff80000000); end
20: begin if (mul96_out_product !== 128'h00000000400000004000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=20 actual=%h expected=%h",mul96_out_product,128'h00000000400000004000000000000000); end
21: begin if (mul96_out_product !== 128'h00000000000000008000000080000000) $fatal(1,"NUMERICAL_mul96_out_product case=21 actual=%h expected=%h",mul96_out_product,128'h00000000000000008000000080000000); end
22: begin if (mul96_out_product !== 128'hffffffffffffffff7fffffff80000000) $fatal(1,"NUMERICAL_mul96_out_product case=22 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffff7fffffff80000000); end
23: begin if (mul96_out_product !== 128'hffffffffc00000004000000080000000) $fatal(1,"NUMERICAL_mul96_out_product case=23 actual=%h expected=%h",mul96_out_product,128'hffffffffc00000004000000080000000); end
24: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=24 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
25: begin if (mul96_out_product !== 128'hffffffffa248edeb65277b87a2702fe3) $fatal(1,"NUMERICAL_mul96_out_product case=25 actual=%h expected=%h",mul96_out_product,128'hffffffffa248edeb65277b87a2702fe3); end
26: begin if (mul96_out_product !== 128'h2a056d2a6f45d9716ebe8fa580000000) $fatal(1,"NUMERICAL_mul96_out_product case=26 actual=%h expected=%h",mul96_out_product,128'h2a056d2a6f45d9716ebe8fa580000000); end
27: begin if (mul96_out_product !== 128'h0125308a95a64e36314f96b83d9e1562) $fatal(1,"NUMERICAL_mul96_out_product case=27 actual=%h expected=%h",mul96_out_product,128'h0125308a95a64e36314f96b83d9e1562); end
28: begin if (mul96_out_product !== 128'h31e60d79c013cef449307e30de1f5bfc) $fatal(1,"NUMERICAL_mul96_out_product case=28 actual=%h expected=%h",mul96_out_product,128'h31e60d79c013cef449307e30de1f5bfc); end
29: begin if (mul96_out_product !== 128'h0f741f38d35201f0c24c08e8f7a9389c) $fatal(1,"NUMERICAL_mul96_out_product case=29 actual=%h expected=%h",mul96_out_product,128'h0f741f38d35201f0c24c08e8f7a9389c); end
30: begin if (mul96_out_product !== 128'h0979bdddeb84c374b4dca13211d8b5ac) $fatal(1,"NUMERICAL_mul96_out_product case=30 actual=%h expected=%h",mul96_out_product,128'h0979bdddeb84c374b4dca13211d8b5ac); end
31: begin if (mul96_out_product !== 128'h1c29e2f03bc11b589a272f65e33c58dd) $fatal(1,"NUMERICAL_mul96_out_product case=31 actual=%h expected=%h",mul96_out_product,128'h1c29e2f03bc11b589a272f65e33c58dd); end
32: begin if (mul96_out_product !== 128'he0b79b5e40cdc5ad4c38ab0da319ed40) $fatal(1,"NUMERICAL_mul96_out_product case=32 actual=%h expected=%h",mul96_out_product,128'he0b79b5e40cdc5ad4c38ab0da319ed40); end
33: begin if (mul96_out_product !== 128'h086dcd411222421e691091f7e3fc5880) $fatal(1,"NUMERICAL_mul96_out_product case=33 actual=%h expected=%h",mul96_out_product,128'h086dcd411222421e691091f7e3fc5880); end
34: begin if (mul96_out_product !== 128'hfcccc84f88cf73a69a09c53dfd974fc6) $fatal(1,"NUMERICAL_mul96_out_product case=34 actual=%h expected=%h",mul96_out_product,128'hfcccc84f88cf73a69a09c53dfd974fc6); end
35: begin if (mul96_out_product !== 128'h058fde9378a48d2ad18912b4f79791f0) $fatal(1,"NUMERICAL_mul96_out_product case=35 actual=%h expected=%h",mul96_out_product,128'h058fde9378a48d2ad18912b4f79791f0); end
36: begin if (mul96_out_product !== 128'hf3880213af4f62b208b30d3b95bb08e9) $fatal(1,"NUMERICAL_mul96_out_product case=36 actual=%h expected=%h",mul96_out_product,128'hf3880213af4f62b208b30d3b95bb08e9); end
37: begin if (mul96_out_product !== 128'hef064590cbf24432ce90dc63c882bb78) $fatal(1,"NUMERICAL_mul96_out_product case=37 actual=%h expected=%h",mul96_out_product,128'hef064590cbf24432ce90dc63c882bb78); end
38: begin if (mul96_out_product !== 128'h16111580220450ac64de342149c3572e) $fatal(1,"NUMERICAL_mul96_out_product case=38 actual=%h expected=%h",mul96_out_product,128'h16111580220450ac64de342149c3572e); end
39: begin if (mul96_out_product !== 128'hf505a5ef5b231c349232a77b65515714) $fatal(1,"NUMERICAL_mul96_out_product case=39 actual=%h expected=%h",mul96_out_product,128'hf505a5ef5b231c349232a77b65515714); end
40: begin if (mul96_out_product !== 128'hffb72b1dcb7c21b6c0049e7ea9933b20) $fatal(1,"NUMERICAL_mul96_out_product case=40 actual=%h expected=%h",mul96_out_product,128'hffb72b1dcb7c21b6c0049e7ea9933b20); end
41: begin if (mul96_out_product !== 128'h008e31263bc93e5be218e28c21a77f8a) $fatal(1,"NUMERICAL_mul96_out_product case=41 actual=%h expected=%h",mul96_out_product,128'h008e31263bc93e5be218e28c21a77f8a); end
42: begin if (mul96_out_product !== 128'hd1978624c99255e78f4233e35c515a20) $fatal(1,"NUMERICAL_mul96_out_product case=42 actual=%h expected=%h",mul96_out_product,128'hd1978624c99255e78f4233e35c515a20); end
43: begin if (mul96_out_product !== 128'hd4b796be261f93c864798067b54e00af) $fatal(1,"NUMERICAL_mul96_out_product case=43 actual=%h expected=%h",mul96_out_product,128'hd4b796be261f93c864798067b54e00af); end
44: begin if (mul96_out_product !== 128'h0adb97abecaef4fa94492fc06a1fbc0a) $fatal(1,"NUMERICAL_mul96_out_product case=44 actual=%h expected=%h",mul96_out_product,128'h0adb97abecaef4fa94492fc06a1fbc0a); end
45: begin if (mul96_out_product !== 128'he9df0596dd0438c86b6ccf8889b60014) $fatal(1,"NUMERICAL_mul96_out_product case=45 actual=%h expected=%h",mul96_out_product,128'he9df0596dd0438c86b6ccf8889b60014); end
46: begin if (mul96_out_product !== 128'h0074e3261e8a188736b1ffd651025e5a) $fatal(1,"NUMERICAL_mul96_out_product case=46 actual=%h expected=%h",mul96_out_product,128'h0074e3261e8a188736b1ffd651025e5a); end
47: begin if (mul96_out_product !== 128'h026169893824bd00a4ce0b2d0017083c) $fatal(1,"NUMERICAL_mul96_out_product case=47 actual=%h expected=%h",mul96_out_product,128'h026169893824bd00a4ce0b2d0017083c); end
48: begin if (mul96_out_product !== 128'hed8b63f054c1c6ddcfc7e207747b4ff0) $fatal(1,"NUMERICAL_mul96_out_product case=48 actual=%h expected=%h",mul96_out_product,128'hed8b63f054c1c6ddcfc7e207747b4ff0); end
49: begin if (mul96_out_product !== 128'h16b3f7fd8f4aed9d5a092bca234f9547) $fatal(1,"NUMERICAL_mul96_out_product case=49 actual=%h expected=%h",mul96_out_product,128'h16b3f7fd8f4aed9d5a092bca234f9547); end
50: begin if (mul96_out_product !== 128'hfb4b7937e1d3f121cb9d43b1912ecea8) $fatal(1,"NUMERICAL_mul96_out_product case=50 actual=%h expected=%h",mul96_out_product,128'hfb4b7937e1d3f121cb9d43b1912ecea8); end
51: begin if (mul96_out_product !== 128'h104ea10ca032a0e9f5429a723b6a9f5c) $fatal(1,"NUMERICAL_mul96_out_product case=51 actual=%h expected=%h",mul96_out_product,128'h104ea10ca032a0e9f5429a723b6a9f5c); end
52: begin if (mul96_out_product !== 128'h32aa77d1b79409bba0d2ede10d11e34a) $fatal(1,"NUMERICAL_mul96_out_product case=52 actual=%h expected=%h",mul96_out_product,128'h32aa77d1b79409bba0d2ede10d11e34a); end
53: begin if (mul96_out_product !== 128'h207607525cc6f90e86840c8cfce55bb8) $fatal(1,"NUMERICAL_mul96_out_product case=53 actual=%h expected=%h",mul96_out_product,128'h207607525cc6f90e86840c8cfce55bb8); end
54: begin if (mul96_out_product !== 128'h2a46f9c181ebe0640bebe96182e1c44d) $fatal(1,"NUMERICAL_mul96_out_product case=54 actual=%h expected=%h",mul96_out_product,128'h2a46f9c181ebe0640bebe96182e1c44d); end
55: begin if (mul96_out_product !== 128'h04f8d00298db2676b49c5cfa6208891c) $fatal(1,"NUMERICAL_mul96_out_product case=55 actual=%h expected=%h",mul96_out_product,128'h04f8d00298db2676b49c5cfa6208891c); end
56: begin if (mul96_out_product !== 128'h0d7219ab4c19a81e9ea2993f9b8bc0b2) $fatal(1,"NUMERICAL_mul96_out_product case=56 actual=%h expected=%h",mul96_out_product,128'h0d7219ab4c19a81e9ea2993f9b8bc0b2); end
57: begin if (mul96_out_product !== 128'hfa93e838a34cebf2eb5b26412ffea570) $fatal(1,"NUMERICAL_mul96_out_product case=57 actual=%h expected=%h",mul96_out_product,128'hfa93e838a34cebf2eb5b26412ffea570); end
58: begin if (mul96_out_product !== 128'hf83ce015d8d06bf347f5fbcea175c900) $fatal(1,"NUMERICAL_mul96_out_product case=58 actual=%h expected=%h",mul96_out_product,128'hf83ce015d8d06bf347f5fbcea175c900); end
59: begin if (mul96_out_product !== 128'h203f750d16d85b765d40c6ba5393de00) $fatal(1,"NUMERICAL_mul96_out_product case=59 actual=%h expected=%h",mul96_out_product,128'h203f750d16d85b765d40c6ba5393de00); end
60: begin if (mul96_out_product !== 128'h296a49806eb7d722690117a770215d9f) $fatal(1,"NUMERICAL_mul96_out_product case=60 actual=%h expected=%h",mul96_out_product,128'h296a49806eb7d722690117a770215d9f); end
61: begin if (mul96_out_product !== 128'h029f7a0f5ffb969817886dd4e2e18fcb) $fatal(1,"NUMERICAL_mul96_out_product case=61 actual=%h expected=%h",mul96_out_product,128'h029f7a0f5ffb969817886dd4e2e18fcb); end
62: begin if (mul96_out_product !== 128'hf453ed5f28159bae98d226cc589a8ab2) $fatal(1,"NUMERICAL_mul96_out_product case=62 actual=%h expected=%h",mul96_out_product,128'hf453ed5f28159bae98d226cc589a8ab2); end
63: begin if (mul96_out_product !== 128'hf9e42cbd4569a28ac48ec0a7ee1fdf90) $fatal(1,"NUMERICAL_mul96_out_product case=63 actual=%h expected=%h",mul96_out_product,128'hf9e42cbd4569a28ac48ec0a7ee1fdf90); end
64: begin if (mul96_out_product !== 128'h07bc3d294832b43aa491cb28fd0ecde0) $fatal(1,"NUMERICAL_mul96_out_product case=64 actual=%h expected=%h",mul96_out_product,128'h07bc3d294832b43aa491cb28fd0ecde0); end
65: begin if (mul96_out_product !== 128'h1521e91b30a0129b45646acdf8941200) $fatal(1,"NUMERICAL_mul96_out_product case=65 actual=%h expected=%h",mul96_out_product,128'h1521e91b30a0129b45646acdf8941200); end
66: begin if (mul96_out_product !== 128'h0781eef9d6ddcf7b612db9aacc6f0038) $fatal(1,"NUMERICAL_mul96_out_product case=66 actual=%h expected=%h",mul96_out_product,128'h0781eef9d6ddcf7b612db9aacc6f0038); end
67: begin if (mul96_out_product !== 128'h0a7304024fd8ca62a89ce32f4a8982cb) $fatal(1,"NUMERICAL_mul96_out_product case=67 actual=%h expected=%h",mul96_out_product,128'h0a7304024fd8ca62a89ce32f4a8982cb); end
68: begin if (mul96_out_product !== 128'h03bca513c999c808108a86b801c07ea8) $fatal(1,"NUMERICAL_mul96_out_product case=68 actual=%h expected=%h",mul96_out_product,128'h03bca513c999c808108a86b801c07ea8); end
69: begin if (mul96_out_product !== 128'h02fb97d8de60696e50784cf88829807c) $fatal(1,"NUMERICAL_mul96_out_product case=69 actual=%h expected=%h",mul96_out_product,128'h02fb97d8de60696e50784cf88829807c); end
70: begin if (mul96_out_product !== 128'h07cef39355b67a009b0b4994b6360a60) $fatal(1,"NUMERICAL_mul96_out_product case=70 actual=%h expected=%h",mul96_out_product,128'h07cef39355b67a009b0b4994b6360a60); end
71: begin if (mul96_out_product !== 128'h02dad39b91d4964ca08a2d24f5a2eae8) $fatal(1,"NUMERICAL_mul96_out_product case=71 actual=%h expected=%h",mul96_out_product,128'h02dad39b91d4964ca08a2d24f5a2eae8); end
72: begin if (mul96_out_product !== 128'h00191f68445e4060979d7ff2e3874593) $fatal(1,"NUMERICAL_mul96_out_product case=72 actual=%h expected=%h",mul96_out_product,128'h00191f68445e4060979d7ff2e3874593); end
73: begin if (mul96_out_product !== 128'h15db41ba82ba44f7bee40fc567360a88) $fatal(1,"NUMERICAL_mul96_out_product case=73 actual=%h expected=%h",mul96_out_product,128'h15db41ba82ba44f7bee40fc567360a88); end
74: begin if (mul96_out_product !== 128'h0177a70014d9e6478cafe55627112fb0) $fatal(1,"NUMERICAL_mul96_out_product case=74 actual=%h expected=%h",mul96_out_product,128'h0177a70014d9e6478cafe55627112fb0); end
75: begin if (mul96_out_product !== 128'hffeb4c92c44de2fc76b12e31d83eb031) $fatal(1,"NUMERICAL_mul96_out_product case=75 actual=%h expected=%h",mul96_out_product,128'hffeb4c92c44de2fc76b12e31d83eb031); end
76: begin if (mul96_out_product !== 128'hff27657634f1decab30570ded63fac13) $fatal(1,"NUMERICAL_mul96_out_product case=76 actual=%h expected=%h",mul96_out_product,128'hff27657634f1decab30570ded63fac13); end
77: begin if (mul96_out_product !== 128'hfffffffffffffffffffffffb00000000) $fatal(1,"NUMERICAL_mul96_out_product case=77 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffffffb00000000); end
78: begin if (mul96_out_product !== 128'h00000000000000000000000000ff0000) $fatal(1,"NUMERICAL_mul96_out_product case=78 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000ff0000); end
79: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=79 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
80: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=80 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
81: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=81 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
82: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=82 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
83: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=83 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
84: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=84 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
85: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=85 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
86: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=86 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
87: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=87 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
88: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=88 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
89: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=89 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
90: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=90 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
91: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=91 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
92: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=92 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
93: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=93 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
94: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=94 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
95: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=95 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
96: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=96 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
97: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=97 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
98: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=98 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
99: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=99 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
100: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=100 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
101: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=101 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
102: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=102 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
103: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=103 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
104: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=104 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
105: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=105 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
106: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=106 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
107: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=107 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
108: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=108 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
109: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=109 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
110: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=110 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
111: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=111 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
112: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=112 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
113: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=113 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
114: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=114 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
115: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=115 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
116: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=116 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
117: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=117 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
118: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=118 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
119: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=119 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
120: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=120 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
121: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=121 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
122: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=122 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
123: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=123 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
124: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=124 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
125: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=125 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
126: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=126 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
127: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=127 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
128: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=128 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
129: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=129 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
130: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=130 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
131: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=131 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
132: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=132 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
133: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=133 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
134: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=134 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
135: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=135 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
136: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=136 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
137: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=137 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
138: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=138 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
139: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=139 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
140: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=140 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
141: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=141 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
142: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=142 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
143: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=143 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
144: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=144 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
145: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=145 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
146: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=146 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
147: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=147 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
148: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=148 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
149: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=149 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
150: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=150 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
151: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=151 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
152: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=152 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
153: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=153 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
154: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=154 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
155: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=155 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
156: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=156 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
157: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=157 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
158: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=158 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
159: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=159 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
160: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=160 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
161: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=161 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
162: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=162 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
163: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=163 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
164: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=164 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
165: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=165 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
166: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=166 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
167: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=167 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
168: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=168 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
169: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=169 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
170: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=170 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
171: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=171 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
172: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=172 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
173: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=173 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
174: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=174 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
175: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=175 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
176: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=176 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
177: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=177 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
178: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=178 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
179: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=179 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
180: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=180 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
181: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=181 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
182: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=182 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
183: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=183 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
184: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=184 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
185: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=185 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
186: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=186 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
187: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=187 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
188: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=188 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
189: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=189 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
190: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=190 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
191: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=191 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
192: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=192 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
193: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=193 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
194: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=194 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
195: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=195 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
196: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=196 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
197: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=197 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
198: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=198 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
199: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=199 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
200: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=200 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
201: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=201 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
202: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=202 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
203: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=203 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
204: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=204 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
205: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=205 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
206: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=206 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
207: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=207 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
208: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=208 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
209: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=209 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
210: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=210 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
211: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=211 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
212: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=212 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
213: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=213 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
214: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=214 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
215: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=215 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
216: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=216 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
217: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=217 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
218: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=218 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
219: begin if (mul96_out_product !== 128'hffffffffffff80000001000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=219 actual=%h expected=%h",mul96_out_product,128'hffffffffffff80000001000000000000); end
220: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=220 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
221: begin if (mul96_out_product !== 128'h00000000000000005b85ec03e2d04a7c) $fatal(1,"NUMERICAL_mul96_out_product case=221 actual=%h expected=%h",mul96_out_product,128'h00000000000000005b85ec03e2d04a7c); end
222: begin if (mul96_out_product !== 128'hfffffffffffffffffffffdcb5c588101) $fatal(1,"NUMERICAL_mul96_out_product case=222 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffffdcb5c588101); end
223: begin if (mul96_out_product !== 128'h000000000000000008ca90899c620434) $fatal(1,"NUMERICAL_mul96_out_product case=223 actual=%h expected=%h",mul96_out_product,128'h000000000000000008ca90899c620434); end
224: begin if (mul96_out_product !== 128'hffffffffffffffffffffffc9c3742bd3) $fatal(1,"NUMERICAL_mul96_out_product case=224 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffffc9c3742bd3); end
225: begin if (mul96_out_product !== 128'hffffffffffffffffefd1e04db0850890) $fatal(1,"NUMERICAL_mul96_out_product case=225 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffefd1e04db0850890); end
226: begin if (mul96_out_product !== 128'h000000000000000000000063d2422b5c) $fatal(1,"NUMERICAL_mul96_out_product case=226 actual=%h expected=%h",mul96_out_product,128'h000000000000000000000063d2422b5c); end
227: begin if (mul96_out_product !== 128'hfffffffffffffffff768745c836012b8) $fatal(1,"NUMERICAL_mul96_out_product case=227 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffff768745c836012b8); end
228: begin if (mul96_out_product !== 128'h00000000000000000000003501ca6c92) $fatal(1,"NUMERICAL_mul96_out_product case=228 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000003501ca6c92); end
229: begin if (mul96_out_product !== 128'hffffffffffffffff808cca0c43ab1628) $fatal(1,"NUMERICAL_mul96_out_product case=229 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffff808cca0c43ab1628); end
230: begin if (mul96_out_product !== 128'h000000000000000000000312490d5e36) $fatal(1,"NUMERICAL_mul96_out_product case=230 actual=%h expected=%h",mul96_out_product,128'h000000000000000000000312490d5e36); end
231: begin if (mul96_out_product !== 128'h00000000000000000df718e72b6ea6c4) $fatal(1,"NUMERICAL_mul96_out_product case=231 actual=%h expected=%h",mul96_out_product,128'h00000000000000000df718e72b6ea6c4); end
232: begin if (mul96_out_product !== 128'hffffffffffffffffffffffa9d7eee0af) $fatal(1,"NUMERICAL_mul96_out_product case=232 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffffa9d7eee0af); end
233: begin if (mul96_out_product !== 128'h000000000000000008e0c886445476c4) $fatal(1,"NUMERICAL_mul96_out_product case=233 actual=%h expected=%h",mul96_out_product,128'h000000000000000008e0c886445476c4); end
234: begin if (mul96_out_product !== 128'hffffffffffffffffffffffc93a60ecaf) $fatal(1,"NUMERICAL_mul96_out_product case=234 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffffc93a60ecaf); end
235: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=235 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
236: begin if (mul96_out_product !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_mul96_out_product case=236 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000000000000000); end
237: begin if (mul96_out_product !== 128'hffffffffffffffff826d405a25d3e328) $fatal(1,"NUMERICAL_mul96_out_product case=237 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffff826d405a25d3e328); end
238: begin if (mul96_out_product !== 128'h000000000000000000000306b4e862f6) $fatal(1,"NUMERICAL_mul96_out_product case=238 actual=%h expected=%h",mul96_out_product,128'h000000000000000000000306b4e862f6); end
239: begin if (mul96_out_product !== 128'h000000000000000033f4169ed58c82b0) $fatal(1,"NUMERICAL_mul96_out_product case=239 actual=%h expected=%h",mul96_out_product,128'h000000000000000033f4169ed58c82b0); end
240: begin if (mul96_out_product !== 128'hfffffffffffffffffffffebf7af2ffd4) $fatal(1,"NUMERICAL_mul96_out_product case=240 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffffebf7af2ffd4); end
241: begin if (mul96_out_product !== 128'hfffffffffffffffff23a87bb6f8c7150) $fatal(1,"NUMERICAL_mul96_out_product case=241 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffff23a87bb6f8c7150); end
242: begin if (mul96_out_product !== 128'h000000000000000000000054f5e5a32c) $fatal(1,"NUMERICAL_mul96_out_product case=242 actual=%h expected=%h",mul96_out_product,128'h000000000000000000000054f5e5a32c); end
243: begin if (mul96_out_product !== 128'hffffffffffffffff9c184234b5e3c998) $fatal(1,"NUMERICAL_mul96_out_product case=243 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffff9c184234b5e3c998); end
244: begin if (mul96_out_product !== 128'h00000000000000000000026859fd63da) $fatal(1,"NUMERICAL_mul96_out_product case=244 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000026859fd63da); end
245: begin if (mul96_out_product !== 128'h000000000000000040a5101adccf0298) $fatal(1,"NUMERICAL_mul96_out_product case=245 actual=%h expected=%h",mul96_out_product,128'h000000000000000040a5101adccf0298); end
246: begin if (mul96_out_product !== 128'hfffffffffffffffffffffe712ed9ed9a) $fatal(1,"NUMERICAL_mul96_out_product case=246 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffffe712ed9ed9a); end
247: begin if (mul96_out_product !== 128'hffffffffffffffffa7929908bbb33140) $fatal(1,"NUMERICAL_mul96_out_product case=247 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffa7929908bbb33140); end
248: begin if (mul96_out_product !== 128'h0000000000000000000002218a5051b0) $fatal(1,"NUMERICAL_mul96_out_product case=248 actual=%h expected=%h",mul96_out_product,128'h0000000000000000000002218a5051b0); end
249: begin if (mul96_out_product !== 128'hffffffffffffffffd63badc59bee3de0) $fatal(1,"NUMERICAL_mul96_out_product case=249 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffd63badc59bee3de0); end
250: begin if (mul96_out_product !== 128'h000000000000000000000101accafd88) $fatal(1,"NUMERICAL_mul96_out_product case=250 actual=%h expected=%h",mul96_out_product,128'h000000000000000000000101accafd88); end
251: begin if (mul96_out_product !== 128'hffffffffffffffff99fbf618d6331240) $fatal(1,"NUMERICAL_mul96_out_product case=251 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffff99fbf618d6331240); end
252: begin if (mul96_out_product !== 128'h0000000000000000000002755f477170) $fatal(1,"NUMERICAL_mul96_out_product case=252 actual=%h expected=%h",mul96_out_product,128'h0000000000000000000002755f477170); end
253: begin if (mul96_out_product !== 128'h00000000000000001e3be736a4043460) $fatal(1,"NUMERICAL_mul96_out_product case=253 actual=%h expected=%h",mul96_out_product,128'h00000000000000001e3be736a4043460); end
254: begin if (mul96_out_product !== 128'hffffffffffffffffffffff4579bd9be8) $fatal(1,"NUMERICAL_mul96_out_product case=254 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffff4579bd9be8); end
255: begin if (mul96_out_product !== 128'h00000000000000000583a4029f58b9c4) $fatal(1,"NUMERICAL_mul96_out_product case=255 actual=%h expected=%h",mul96_out_product,128'h00000000000000000583a4029f58b9c4); end
256: begin if (mul96_out_product !== 128'hffffffffffffffffffffffddfb1423ef) $fatal(1,"NUMERICAL_mul96_out_product case=256 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffffddfb1423ef); end
257: begin if (mul96_out_product !== 128'hfffffffffffffffff651b678e5d2dc3c) $fatal(1,"NUMERICAL_mul96_out_product case=257 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffff651b678e5d2dc3c); end
258: begin if (mul96_out_product !== 128'h00000000000000000000003bb9730691) $fatal(1,"NUMERICAL_mul96_out_product case=258 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000003bb9730691); end
259: begin if (mul96_out_product !== 128'h0000000000000000080f5dd104dc61b8) $fatal(1,"NUMERICAL_mul96_out_product case=259 actual=%h expected=%h",mul96_out_product,128'h0000000000000000080f5dd104dc61b8); end
260: begin if (mul96_out_product !== 128'hffffffffffffffffffffffce4658c0d2) $fatal(1,"NUMERICAL_mul96_out_product case=260 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffffce4658c0d2); end
261: begin if (mul96_out_product !== 128'hfffffffffffffffffcfab1a5ed1fe1e0) $fatal(1,"NUMERICAL_mul96_out_product case=261 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffcfab1a5ed1fe1e0); end
262: begin if (mul96_out_product !== 128'h000000000000000000000012a2cdf488) $fatal(1,"NUMERICAL_mul96_out_product case=262 actual=%h expected=%h",mul96_out_product,128'h000000000000000000000012a2cdf488); end
263: begin if (mul96_out_product !== 128'h00000000000000001ca489acfd629b30) $fatal(1,"NUMERICAL_mul96_out_product case=263 actual=%h expected=%h",mul96_out_product,128'h00000000000000001ca489acfd629b30); end
264: begin if (mul96_out_product !== 128'hffffffffffffffffffffff4f4aecc5b4) $fatal(1,"NUMERICAL_mul96_out_product case=264 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffff4f4aecc5b4); end
265: begin if (mul96_out_product !== 128'hffffffffffffffffa67bc322ba784b94) $fatal(1,"NUMERICAL_mul96_out_product case=265 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffa67bc322ba784b94); end
266: begin if (mul96_out_product !== 128'h000000000000000000000228428d0afb) $fatal(1,"NUMERICAL_mul96_out_product case=266 actual=%h expected=%h",mul96_out_product,128'h000000000000000000000228428d0afb); end
267: begin if (mul96_out_product !== 128'h0000000000000000093c9c5c04047d00) $fatal(1,"NUMERICAL_mul96_out_product case=267 actual=%h expected=%h",mul96_out_product,128'h0000000000000000093c9c5c04047d00); end
268: begin if (mul96_out_product !== 128'hffffffffffffffffffffffc703dc98c0) $fatal(1,"NUMERICAL_mul96_out_product case=268 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffffc703dc98c0); end
269: begin if (mul96_out_product !== 128'hffffffffffffebb52b4d48175ab7a688) $fatal(1,"NUMERICAL_mul96_out_product case=269 actual=%h expected=%h",mul96_out_product,128'hffffffffffffebb52b4d48175ab7a688); end
270: begin if (mul96_out_product !== 128'h00000000000000000000385fa85bbc7c) $fatal(1,"NUMERICAL_mul96_out_product case=270 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000385fa85bbc7c); end
271: begin if (mul96_out_product !== 128'h0000000000001055389cd8f074135376) $fatal(1,"NUMERICAL_mul96_out_product case=271 actual=%h expected=%h",mul96_out_product,128'h0000000000001055389cd8f074135376); end
272: begin if (mul96_out_product !== 128'hffffffffffffffffffffd2a03b499595) $fatal(1,"NUMERICAL_mul96_out_product case=272 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffd2a03b499595); end
273: begin if (mul96_out_product !== 128'hfffffffffffffeb3421d2236ef9b5f9c) $fatal(1,"NUMERICAL_mul96_out_product case=273 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffeb3421d2236ef9b5f9c); end
274: begin if (mul96_out_product !== 128'h00000000000000000000039c62206152) $fatal(1,"NUMERICAL_mul96_out_product case=274 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000039c62206152); end
275: begin if (mul96_out_product !== 128'h00000000000005400510a43679c06b52) $fatal(1,"NUMERICAL_mul96_out_product case=275 actual=%h expected=%h",mul96_out_product,128'h00000000000005400510a43679c06b52); end
276: begin if (mul96_out_product !== 128'hfffffffffffffffffffff16a347b78c7) $fatal(1,"NUMERICAL_mul96_out_product case=276 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffff16a347b78c7); end
277: begin if (mul96_out_product !== 128'h0000000000000c3243c41ae2fd314ca0) $fatal(1,"NUMERICAL_mul96_out_product case=277 actual=%h expected=%h",mul96_out_product,128'h0000000000000c3243c41ae2fd314ca0); end
278: begin if (mul96_out_product !== 128'hffffffffffffffffffffde1e190144b0) $fatal(1,"NUMERICAL_mul96_out_product case=278 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffde1e190144b0); end
279: begin if (mul96_out_product !== 128'hffffffffffffffdb6a7c6dcd7cf1f26a) $fatal(1,"NUMERICAL_mul96_out_product case=279 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffdb6a7c6dcd7cf1f26a); end
280: begin if (mul96_out_product !== 128'h000000000000000000000065a226887b) $fatal(1,"NUMERICAL_mul96_out_product case=280 actual=%h expected=%h",mul96_out_product,128'h000000000000000000000065a226887b); end
281: begin if (mul96_out_product !== 128'hfffffffffffffc26cd941906535d26d0) $fatal(1,"NUMERICAL_mul96_out_product case=281 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffc26cd941906535d26d0); end
282: begin if (mul96_out_product !== 128'h000000000000000000000ab0f4d29e18) $fatal(1,"NUMERICAL_mul96_out_product case=282 actual=%h expected=%h",mul96_out_product,128'h000000000000000000000ab0f4d29e18); end
283: begin if (mul96_out_product !== 128'h0000000000000082d85ecab836a2234e) $fatal(1,"NUMERICAL_mul96_out_product case=283 actual=%h expected=%h",mul96_out_product,128'h0000000000000082d85ecab836a2234e); end
284: begin if (mul96_out_product !== 128'hfffffffffffffffffffffe9480641ae9) $fatal(1,"NUMERICAL_mul96_out_product case=284 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffffe9480641ae9); end
285: begin if (mul96_out_product !== 128'h00000000000000e368e76027177de3bc) $fatal(1,"NUMERICAL_mul96_out_product case=285 actual=%h expected=%h",mul96_out_product,128'h00000000000000e368e76027177de3bc); end
286: begin if (mul96_out_product !== 128'hfffffffffffffffffffffd883cc30e42) $fatal(1,"NUMERICAL_mul96_out_product case=286 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffffd883cc30e42); end
287: begin if (mul96_out_product !== 128'h000000000000000cda5dcd25811e9098) $fatal(1,"NUMERICAL_mul96_out_product case=287 actual=%h expected=%h",mul96_out_product,128'h000000000000000cda5dcd25811e9098); end
288: begin if (mul96_out_product !== 128'hffffffffffffffffffffffdc4b18fef4) $fatal(1,"NUMERICAL_mul96_out_product case=288 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffffdc4b18fef4); end
289: begin if (mul96_out_product !== 128'h00000000000002da688b9c4643d35238) $fatal(1,"NUMERICAL_mul96_out_product case=289 actual=%h expected=%h",mul96_out_product,128'h00000000000002da688b9c4643d35238); end
290: begin if (mul96_out_product !== 128'hfffffffffffffffffffff812dde76124) $fatal(1,"NUMERICAL_mul96_out_product case=290 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffff812dde76124); end
291: begin if (mul96_out_product !== 128'hfffffffffffff4d441ffd00917f28ed8) $fatal(1,"NUMERICAL_mul96_out_product case=291 actual=%h expected=%h",mul96_out_product,128'hfffffffffffff4d441ffd00917f28ed8); end
292: begin if (mul96_out_product !== 128'h000000000000000000001f0897fa2dd4) $fatal(1,"NUMERICAL_mul96_out_product case=292 actual=%h expected=%h",mul96_out_product,128'h000000000000000000001f0897fa2dd4); end
293: begin if (mul96_out_product !== 128'hffffffffffffffd175709eb716040df8) $fatal(1,"NUMERICAL_mul96_out_product case=293 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffd175709eb716040df8); end
294: begin if (mul96_out_product !== 128'h0000000000000000000000814b9b0544) $fatal(1,"NUMERICAL_mul96_out_product case=294 actual=%h expected=%h",mul96_out_product,128'h0000000000000000000000814b9b0544); end
295: begin if (mul96_out_product !== 128'hfffffffffffff507d25c81e9249b83a8) $fatal(1,"NUMERICAL_mul96_out_product case=295 actual=%h expected=%h",mul96_out_product,128'hfffffffffffff507d25c81e9249b83a8); end
296: begin if (mul96_out_product !== 128'h000000000000000000001e79584f74ec) $fatal(1,"NUMERICAL_mul96_out_product case=296 actual=%h expected=%h",mul96_out_product,128'h000000000000000000001e79584f74ec); end
297: begin if (mul96_out_product !== 128'h00000000000000dc84dbcd11635a450e) $fatal(1,"NUMERICAL_mul96_out_product case=297 actual=%h expected=%h",mul96_out_product,128'h00000000000000dc84dbcd11635a450e); end
298: begin if (mul96_out_product !== 128'hfffffffffffffffffffffd9b616bdc09) $fatal(1,"NUMERICAL_mul96_out_product case=298 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffffd9b616bdc09); end
299: begin if (mul96_out_product !== 128'h0000000000000bb0932f3fecdb5a8d78) $fatal(1,"NUMERICAL_mul96_out_product case=299 actual=%h expected=%h",mul96_out_product,128'h0000000000000bb0932f3fecdb5a8d78); end
300: begin if (mul96_out_product !== 128'hffffffffffffffffffffdf8662e38984) $fatal(1,"NUMERICAL_mul96_out_product case=300 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffdf8662e38984); end
301: begin if (mul96_out_product !== 128'h000000000000067b2ee2a0354b9360da) $fatal(1,"NUMERICAL_mul96_out_product case=301 actual=%h expected=%h",mul96_out_product,128'h000000000000067b2ee2a0354b9360da); end
302: begin if (mul96_out_product !== 128'hffffffffffffffffffffedfea7e695c3) $fatal(1,"NUMERICAL_mul96_out_product case=302 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffedfea7e695c3); end
303: begin if (mul96_out_product !== 128'h00000000000007e083c3c3370685b3c8) $fatal(1,"NUMERICAL_mul96_out_product case=303 actual=%h expected=%h",mul96_out_product,128'h00000000000007e083c3c3370685b3c8); end
304: begin if (mul96_out_product !== 128'hffffffffffffffffffffea1df5c6ebdc) $fatal(1,"NUMERICAL_mul96_out_product case=304 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffea1df5c6ebdc); end
305: begin if (mul96_out_product !== 128'hfffffffffffffe8b9295a07a080cccc0) $fatal(1,"NUMERICAL_mul96_out_product case=305 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffe8b9295a07a080cccc0); end
306: begin if (mul96_out_product !== 128'h00000000000000000000040aa21d93a0) $fatal(1,"NUMERICAL_mul96_out_product case=306 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000040aa21d93a0); end
307: begin if (mul96_out_product !== 128'hfffffffffffff54a58d343ed74215622) $fatal(1,"NUMERICAL_mul96_out_product case=307 actual=%h expected=%h",mul96_out_product,128'hfffffffffffff54a58d343ed74215622); end
308: begin if (mul96_out_product !== 128'h000000000000000000001dc0885014df) $fatal(1,"NUMERICAL_mul96_out_product case=308 actual=%h expected=%h",mul96_out_product,128'h000000000000000000001dc0885014df); end
309: begin if (mul96_out_product !== 128'h0000000000000575e977a9b5d747f33e) $fatal(1,"NUMERICAL_mul96_out_product case=309 actual=%h expected=%h",mul96_out_product,128'h0000000000000575e977a9b5d747f33e); end
310: begin if (mul96_out_product !== 128'hfffffffffffffffffffff0d47cf7ab71) $fatal(1,"NUMERICAL_mul96_out_product case=310 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffff0d47cf7ab71); end
311: begin if (mul96_out_product !== 128'h00000000000001b3bb43a72d2088ade4) $fatal(1,"NUMERICAL_mul96_out_product case=311 actual=%h expected=%h",mul96_out_product,128'h00000000000001b3bb43a72d2088ade4); end
312: begin if (mul96_out_product !== 128'hfffffffffffffffffffffb4580bbebee) $fatal(1,"NUMERICAL_mul96_out_product case=312 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffffb4580bbebee); end
313: begin if (mul96_out_product !== 128'h0000000000000430d1c5e2d20c289104) $fatal(1,"NUMERICAL_mul96_out_product case=313 actual=%h expected=%h",mul96_out_product,128'h0000000000000430d1c5e2d20c289104); end
314: begin if (mul96_out_product !== 128'hfffffffffffffffffffff45b9f14715e) $fatal(1,"NUMERICAL_mul96_out_product case=314 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffff45b9f14715e); end
315: begin if (mul96_out_product !== 128'hfffffffffffffbf5af6d2d360619c234) $fatal(1,"NUMERICAL_mul96_out_product case=315 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffbf5af6d2d360619c234); end
316: begin if (mul96_out_product !== 128'h000000000000000000000b3968d3e746) $fatal(1,"NUMERICAL_mul96_out_product case=316 actual=%h expected=%h",mul96_out_product,128'h000000000000000000000b3968d3e746); end
317: begin if (mul96_out_product !== 128'hffffffffffffffffc907ff4f367f65de) $fatal(1,"NUMERICAL_mul96_out_product case=317 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffc907ff4f367f65de); end
318: begin if (mul96_out_product !== 128'h00000000000000000000012e50b7cafd) $fatal(1,"NUMERICAL_mul96_out_product case=318 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000012e50b7cafd); end
319: begin if (mul96_out_product !== 128'hfffffffffffffffffbaeec96f85531b0) $fatal(1,"NUMERICAL_mul96_out_product case=319 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffbaeec96f85531b0); end
320: begin if (mul96_out_product !== 128'h000000000000000000000017bda87a08) $fatal(1,"NUMERICAL_mul96_out_product case=320 actual=%h expected=%h",mul96_out_product,128'h000000000000000000000017bda87a08); end
321: begin if (mul96_out_product !== 128'h00000000000000000a8844b4ebd9f092) $fatal(1,"NUMERICAL_mul96_out_product case=321 actual=%h expected=%h",mul96_out_product,128'h00000000000000000a8844b4ebd9f092); end
322: begin if (mul96_out_product !== 128'hffffffffffffffffffffffc61327d42b) $fatal(1,"NUMERICAL_mul96_out_product case=322 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffffc61327d42b); end
323: begin if (mul96_out_product !== 128'h00000000000000006075ac9d1972bd96) $fatal(1,"NUMERICAL_mul96_out_product case=323 actual=%h expected=%h",mul96_out_product,128'h00000000000000006075ac9d1972bd96); end
324: begin if (mul96_out_product !== 128'hfffffffffffffffffffffded7e93b151) $fatal(1,"NUMERICAL_mul96_out_product case=324 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffffded7e93b151); end
325: begin if (mul96_out_product !== 128'h00000000000000000014a8cf9f3e3a9c) $fatal(1,"NUMERICAL_mul96_out_product case=325 actual=%h expected=%h",mul96_out_product,128'h00000000000000000014a8cf9f3e3a9c); end
326: begin if (mul96_out_product !== 128'hffffffffffffffffffffffff8e60c74a) $fatal(1,"NUMERICAL_mul96_out_product case=326 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffffff8e60c74a); end
327: begin if (mul96_out_product !== 128'h000000000000000016ed0ca758ffa260) $fatal(1,"NUMERICAL_mul96_out_product case=327 actual=%h expected=%h",mul96_out_product,128'h000000000000000016ed0ca758ffa260); end
328: begin if (mul96_out_product !== 128'hffffffffffffffffffffff81e99a6a90) $fatal(1,"NUMERICAL_mul96_out_product case=328 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffff81e99a6a90); end
329: begin if (mul96_out_product !== 128'h00000000000000004c63618bad44b9ce) $fatal(1,"NUMERICAL_mul96_out_product case=329 actual=%h expected=%h",mul96_out_product,128'h00000000000000004c63618bad44b9ce); end
330: begin if (mul96_out_product !== 128'hfffffffffffffffffffffe5be1fc6265) $fatal(1,"NUMERICAL_mul96_out_product case=330 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffffe5be1fc6265); end
331: begin if (mul96_out_product !== 128'h00000000000000000942cf225bedb6cc) $fatal(1,"NUMERICAL_mul96_out_product case=331 actual=%h expected=%h",mul96_out_product,128'h00000000000000000942cf225bedb6cc); end
332: begin if (mul96_out_product !== 128'hffffffffffffffffffffffcd111af512) $fatal(1,"NUMERICAL_mul96_out_product case=332 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffffcd111af512); end
333: begin if (mul96_out_product !== 128'hffffffffffffffff9d7003d48de86fd0) $fatal(1,"NUMERICAL_mul96_out_product case=333 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffff9d7003d48de86fd0); end
334: begin if (mul96_out_product !== 128'h00000000000000000000021e12019438) $fatal(1,"NUMERICAL_mul96_out_product case=334 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000021e12019438); end
335: begin if (mul96_out_product !== 128'hffffffffffffffffeb7390cd3164e974) $fatal(1,"NUMERICAL_mul96_out_product case=335 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffeb7390cd3164e974); end
336: begin if (mul96_out_product !== 128'h0000000000000000000000710328154e) $fatal(1,"NUMERICAL_mul96_out_product case=336 actual=%h expected=%h",mul96_out_product,128'h0000000000000000000000710328154e); end
337: begin if (mul96_out_product !== 128'h00000000000000005c5c4256b028d482) $fatal(1,"NUMERICAL_mul96_out_product case=337 actual=%h expected=%h",mul96_out_product,128'h00000000000000005c5c4256b028d482); end
338: begin if (mul96_out_product !== 128'hfffffffffffffffffffffe040a1d4393) $fatal(1,"NUMERICAL_mul96_out_product case=338 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffffe040a1d4393); end
339: begin if (mul96_out_product !== 128'hffffffffffffffffe74e8813f7a73498) $fatal(1,"NUMERICAL_mul96_out_product case=339 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffe74e8813f7a73498); end
340: begin if (mul96_out_product !== 128'h000000000000000000000087ce986ca4) $fatal(1,"NUMERICAL_mul96_out_product case=340 actual=%h expected=%h",mul96_out_product,128'h000000000000000000000087ce986ca4); end
341: begin if (mul96_out_product !== 128'h00000000000000001877cbf9b2f56920) $fatal(1,"NUMERICAL_mul96_out_product case=341 actual=%h expected=%h",mul96_out_product,128'h00000000000000001877cbf9b2f56920); end
342: begin if (mul96_out_product !== 128'hffffffffffffffffffffff796e95d2b0) $fatal(1,"NUMERICAL_mul96_out_product case=342 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffff796e95d2b0); end
343: begin if (mul96_out_product !== 128'h00000000000000001f139b4a8d6f4f00) $fatal(1,"NUMERICAL_mul96_out_product case=343 actual=%h expected=%h",mul96_out_product,128'h00000000000000001f139b4a8d6f4f00); end
344: begin if (mul96_out_product !== 128'hffffffffffffffffffffff5516070e80) $fatal(1,"NUMERICAL_mul96_out_product case=344 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffff5516070e80); end
345: begin if (mul96_out_product !== 128'hffffffffffffffffa1732f3ee71eef14) $fatal(1,"NUMERICAL_mul96_out_product case=345 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffa1732f3ee71eef14); end
346: begin if (mul96_out_product !== 128'h00000000000000000000020800d066be) $fatal(1,"NUMERICAL_mul96_out_product case=346 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000020800d066be); end
347: begin if (mul96_out_product !== 128'h000000000000000056a167df40eafc00) $fatal(1,"NUMERICAL_mul96_out_product case=347 actual=%h expected=%h",mul96_out_product,128'h000000000000000056a167df40eafc00); end
348: begin if (mul96_out_product !== 128'hfffffffffffffffffffffe238d76da00) $fatal(1,"NUMERICAL_mul96_out_product case=348 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffffe238d76da00); end
349: begin if (mul96_out_product !== 128'hffffffffffffffffe1f92e1e0de45820) $fatal(1,"NUMERICAL_mul96_out_product case=349 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffe1f92e1e0de45820); end
350: begin if (mul96_out_product !== 128'h0000000000000000000000a523b55130) $fatal(1,"NUMERICAL_mul96_out_product case=350 actual=%h expected=%h",mul96_out_product,128'h0000000000000000000000a523b55130); end
351: begin if (mul96_out_product !== 128'h00000000000000002772d88ce899e412) $fatal(1,"NUMERICAL_mul96_out_product case=351 actual=%h expected=%h",mul96_out_product,128'h00000000000000002772d88ce899e412); end
352: begin if (mul96_out_product !== 128'hffffffffffffffffffffff270ab6ad6b) $fatal(1,"NUMERICAL_mul96_out_product case=352 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffff270ab6ad6b); end
353: begin if (mul96_out_product !== 128'h000000000000000005e5d15663b8df6c) $fatal(1,"NUMERICAL_mul96_out_product case=353 actual=%h expected=%h",mul96_out_product,128'h000000000000000005e5d15663b8df6c); end
354: begin if (mul96_out_product !== 128'hffffffffffffffffffffffdf905b3302) $fatal(1,"NUMERICAL_mul96_out_product case=354 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffffdf905b3302); end
355: begin if (mul96_out_product !== 128'h00000000000000002a970235866f2f68) $fatal(1,"NUMERICAL_mul96_out_product case=355 actual=%h expected=%h",mul96_out_product,128'h00000000000000002a970235866f2f68); end
356: begin if (mul96_out_product !== 128'hffffffffffffffffffffff15c401c95c) $fatal(1,"NUMERICAL_mul96_out_product case=356 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffff15c401c95c); end
357: begin if (mul96_out_product !== 128'h0000000000000000088cbf864fc5a312) $fatal(1,"NUMERICAL_mul96_out_product case=357 actual=%h expected=%h",mul96_out_product,128'h0000000000000000088cbf864fc5a312); end
358: begin if (mul96_out_product !== 128'hffffffffffffffffffffffd0fa65e3eb) $fatal(1,"NUMERICAL_mul96_out_product case=358 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffffd0fa65e3eb); end
359: begin if (mul96_out_product !== 128'h00000000000000002dcdceb8fd5ba830) $fatal(1,"NUMERICAL_mul96_out_product case=359 actual=%h expected=%h",mul96_out_product,128'h00000000000000002dcdceb8fd5ba830); end
360: begin if (mul96_out_product !== 128'hffffffffffffffffffffff0416ce4fc8) $fatal(1,"NUMERICAL_mul96_out_product case=360 actual=%h expected=%h",mul96_out_product,128'hffffffffffffffffffffff0416ce4fc8); end
361: begin if (mul96_out_product !== 128'h00000000000000005bb3c44c914cdb26) $fatal(1,"NUMERICAL_mul96_out_product case=361 actual=%h expected=%h",mul96_out_product,128'h00000000000000005bb3c44c914cdb26); end
362: begin if (mul96_out_product !== 128'hfffffffffffffffffffffe07a8c86029) $fatal(1,"NUMERICAL_mul96_out_product case=362 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffffffffe07a8c86029); end
363: begin if (mul96_out_product !== 128'hfffffffffffffffff27740d4e7d29d68) $fatal(1,"NUMERICAL_mul96_out_product case=363 actual=%h expected=%h",mul96_out_product,128'hfffffffffffffffff27740d4e7d29d68); end
364: begin if (mul96_out_product !== 128'h00000000000000000000004a6f4b9e5c) $fatal(1,"NUMERICAL_mul96_out_product case=364 actual=%h expected=%h",mul96_out_product,128'h00000000000000000000004a6f4b9e5c); end
endcase
held={1'b1,{mul96_out_product}};
@(negedge clk); mul96_iv=0;
repeat(3) begin @(posedge clk);
if ({mul96_ov,{mul96_out_product}} !== held) $fatal(1,"STALLED_mul96");
#1;
if ({mul96_ov,{mul96_out_product}} !== held) $fatal(1,"STALLED_POST_mul96");
end
@(negedge clk); mul96_or=1; @(posedge clk); #1;
if (mul96_ov !== 1'b0) $fatal(1,"RETIRE_mul96");
@(negedge clk); mul96_or=0;
comparisons=comparisons+1;
end endtask
task automatic run_udiv(input integer index);
reg [193:0] held;
integer elapsed;
begin
@(negedge clk);
while (udiv_ir !== 1'b1) @(negedge clk);
case(index)
0: begin udiv_numerator=128'h00000000000000000000000000000000; udiv_denominator=64'h0000000000000001; end
1: begin udiv_numerator=128'hffffffffffffffffffffffffffffffff; udiv_denominator=64'h0000000000000001; end
2: begin udiv_numerator=128'hffffffffffffffffffffffffffffffff; udiv_denominator=64'hffffffffffffffff; end
3: begin udiv_numerator=128'h00000000000000000000000100000000; udiv_denominator=64'h0000000000000018; end
4: begin udiv_numerator=128'h00000000000000010000000000000000; udiv_denominator=64'h0000000001000005; end
5: begin udiv_numerator=128'h00000000000000000000000000000000; udiv_denominator=64'h0000000000000018; end
6: begin udiv_numerator=128'h00000000000000010000000000000000; udiv_denominator=64'h0000000001000000; end
7: begin udiv_numerator=128'h00000005fffffff40000000c00000000; udiv_denominator=64'h0000000000000018; end
8: begin udiv_numerator=128'h00000000000000010000000000000000; udiv_denominator=64'h00007fffffff8001; end
9: begin udiv_numerator=128'h0000000000000000000007c200000000; udiv_denominator=64'h0000000000000018; end
10: begin udiv_numerator=128'h00000000000000010000000000000000; udiv_denominator=64'h000000000100295c; end
11: begin udiv_numerator=128'h0000000000000008ec26cd0900000000; udiv_denominator=64'h0000000000000018; end
12: begin udiv_numerator=128'h00000000000000010000000000000000; udiv_denominator=64'h000000009c180529; end
13: begin udiv_numerator=128'h0000000000000000000008b400000000; udiv_denominator=64'h0000000000000018; end
14: begin udiv_numerator=128'h00000000000000010000000000000000; udiv_denominator=64'h0000000001002e66; end
15: begin udiv_numerator=128'h0000000000000000000000000000007b; udiv_denominator=64'h0000000000000000; end
default: $fatal(1,"BAD_CASE");
endcase
udiv_iv=1; @(posedge clk);
if (udiv_ir !== 1'b1) $fatal(1,"ACCEPT_udiv");
#1; elapsed=0;
repeat (129) begin
if (udiv_ov !== 1'b0) $fatal(1,"EARLY_VALID_udiv edge=%0d",elapsed);
@(negedge clk); udiv_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
if (udiv_ov !== 1'b1) $fatal(1,"LATE_VALID_udiv edge=%0d",elapsed);
case(index)
0: begin if (udiv_quotient !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_udiv_quotient case=0 actual=%h expected=%h",udiv_quotient,128'h00000000000000000000000000000000); if (udiv_remainder !== 64'h0000000000000000) $fatal(1,"NUMERICAL_udiv_remainder case=0 actual=%h expected=%h",udiv_remainder,64'h0000000000000000); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=0 actual=%h expected=%h",udiv_out_error,1'h0); end
1: begin if (udiv_quotient !== 128'hffffffffffffffffffffffffffffffff) $fatal(1,"NUMERICAL_udiv_quotient case=1 actual=%h expected=%h",udiv_quotient,128'hffffffffffffffffffffffffffffffff); if (udiv_remainder !== 64'h0000000000000000) $fatal(1,"NUMERICAL_udiv_remainder case=1 actual=%h expected=%h",udiv_remainder,64'h0000000000000000); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=1 actual=%h expected=%h",udiv_out_error,1'h0); end
2: begin if (udiv_quotient !== 128'h00000000000000010000000000000001) $fatal(1,"NUMERICAL_udiv_quotient case=2 actual=%h expected=%h",udiv_quotient,128'h00000000000000010000000000000001); if (udiv_remainder !== 64'h0000000000000000) $fatal(1,"NUMERICAL_udiv_remainder case=2 actual=%h expected=%h",udiv_remainder,64'h0000000000000000); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=2 actual=%h expected=%h",udiv_out_error,1'h0); end
3: begin if (udiv_quotient !== 128'h0000000000000000000000000aaaaaaa) $fatal(1,"NUMERICAL_udiv_quotient case=3 actual=%h expected=%h",udiv_quotient,128'h0000000000000000000000000aaaaaaa); if (udiv_remainder !== 64'h0000000000000010) $fatal(1,"NUMERICAL_udiv_remainder case=3 actual=%h expected=%h",udiv_remainder,64'h0000000000000010); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=3 actual=%h expected=%h",udiv_out_error,1'h0); end
4: begin if (udiv_quotient !== 128'h0000000000000000000000fffffb0000) $fatal(1,"NUMERICAL_udiv_quotient case=4 actual=%h expected=%h",udiv_quotient,128'h0000000000000000000000fffffb0000); if (udiv_remainder !== 64'h0000000000190000) $fatal(1,"NUMERICAL_udiv_remainder case=4 actual=%h expected=%h",udiv_remainder,64'h0000000000190000); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=4 actual=%h expected=%h",udiv_out_error,1'h0); end
5: begin if (udiv_quotient !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_udiv_quotient case=5 actual=%h expected=%h",udiv_quotient,128'h00000000000000000000000000000000); if (udiv_remainder !== 64'h0000000000000000) $fatal(1,"NUMERICAL_udiv_remainder case=5 actual=%h expected=%h",udiv_remainder,64'h0000000000000000); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=5 actual=%h expected=%h",udiv_out_error,1'h0); end
6: begin if (udiv_quotient !== 128'h00000000000000000000010000000000) $fatal(1,"NUMERICAL_udiv_quotient case=6 actual=%h expected=%h",udiv_quotient,128'h00000000000000000000010000000000); if (udiv_remainder !== 64'h0000000000000000) $fatal(1,"NUMERICAL_udiv_remainder case=6 actual=%h expected=%h",udiv_remainder,64'h0000000000000000); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=6 actual=%h expected=%h",udiv_out_error,1'h0); end
7: begin if (udiv_quotient !== 128'h000000003fffffff8000000080000000) $fatal(1,"NUMERICAL_udiv_quotient case=7 actual=%h expected=%h",udiv_quotient,128'h000000003fffffff8000000080000000); if (udiv_remainder !== 64'h0000000000000000) $fatal(1,"NUMERICAL_udiv_remainder case=7 actual=%h expected=%h",udiv_remainder,64'h0000000000000000); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=7 actual=%h expected=%h",udiv_out_error,1'h0); end
8: begin if (udiv_quotient !== 128'h00000000000000000000000000020000) $fatal(1,"NUMERICAL_udiv_quotient case=8 actual=%h expected=%h",udiv_quotient,128'h00000000000000000000000000020000); if (udiv_remainder !== 64'h00000000fffe0000) $fatal(1,"NUMERICAL_udiv_remainder case=8 actual=%h expected=%h",udiv_remainder,64'h00000000fffe0000); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=8 actual=%h expected=%h",udiv_out_error,1'h0); end
9: begin if (udiv_quotient !== 128'h000000000000000000000052c0000000) $fatal(1,"NUMERICAL_udiv_quotient case=9 actual=%h expected=%h",udiv_quotient,128'h000000000000000000000052c0000000); if (udiv_remainder !== 64'h0000000000000000) $fatal(1,"NUMERICAL_udiv_remainder case=9 actual=%h expected=%h",udiv_remainder,64'h0000000000000000); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=9 actual=%h expected=%h",udiv_out_error,1'h0); end
10: begin if (udiv_quotient !== 128'h0000000000000000000000ffd6aaad84) $fatal(1,"NUMERICAL_udiv_quotient case=10 actual=%h expected=%h",udiv_quotient,128'h0000000000000000000000ffd6aaad84); if (udiv_remainder !== 64'h0000000000df8090) $fatal(1,"NUMERICAL_udiv_remainder case=10 actual=%h expected=%h",udiv_remainder,64'h0000000000df8090); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=10 actual=%h expected=%h",udiv_out_error,1'h0); end
11: begin if (udiv_quotient !== 128'h00000000000000005f2c488b0aaaaaaa) $fatal(1,"NUMERICAL_udiv_quotient case=11 actual=%h expected=%h",udiv_quotient,128'h00000000000000005f2c488b0aaaaaaa); if (udiv_remainder !== 64'h0000000000000010) $fatal(1,"NUMERICAL_udiv_remainder case=11 actual=%h expected=%h",udiv_remainder,64'h0000000000000010); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=11 actual=%h expected=%h",udiv_out_error,1'h0); end
12: begin if (udiv_quotient !== 128'h000000000000000000000001a3d99c1e) $fatal(1,"NUMERICAL_udiv_quotient case=12 actual=%h expected=%h",udiv_quotient,128'h000000000000000000000001a3d99c1e); if (udiv_remainder !== 64'h0000000097496932) $fatal(1,"NUMERICAL_udiv_remainder case=12 actual=%h expected=%h",udiv_remainder,64'h0000000097496932); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=12 actual=%h expected=%h",udiv_out_error,1'h0); end
13: begin if (udiv_quotient !== 128'h00000000000000000000005cd5555555) $fatal(1,"NUMERICAL_udiv_quotient case=13 actual=%h expected=%h",udiv_quotient,128'h00000000000000000000005cd5555555); if (udiv_remainder !== 64'h0000000000000008) $fatal(1,"NUMERICAL_udiv_remainder case=13 actual=%h expected=%h",udiv_remainder,64'h0000000000000008); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=13 actual=%h expected=%h",udiv_out_error,1'h0); end
14: begin if (udiv_quotient !== 128'h0000000000000000000000ffd1a2674a) $fatal(1,"NUMERICAL_udiv_quotient case=14 actual=%h expected=%h",udiv_quotient,128'h0000000000000000000000ffd1a2674a); if (udiv_remainder !== 64'h0000000000bb8c84) $fatal(1,"NUMERICAL_udiv_remainder case=14 actual=%h expected=%h",udiv_remainder,64'h0000000000bb8c84); if (udiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_udiv_out_error case=14 actual=%h expected=%h",udiv_out_error,1'h0); end
15: begin if (udiv_out_error !== 1'h1) $fatal(1,"NUMERICAL_udiv_out_error case=15 actual=%h expected=%h",udiv_out_error,1'h1); end
endcase
held={1'b1,{udiv_quotient,udiv_remainder,udiv_out_error}};
@(negedge clk); udiv_iv=0;
repeat(3) begin @(posedge clk);
if ({udiv_ov,{udiv_quotient,udiv_remainder,udiv_out_error}} !== held) $fatal(1,"STALLED_udiv");
#1;
if ({udiv_ov,{udiv_quotient,udiv_remainder,udiv_out_error}} !== held) $fatal(1,"STALLED_POST_udiv");
end
@(negedge clk); udiv_or=1; @(posedge clk); #1;
if (udiv_ov !== 1'b0) $fatal(1,"RETIRE_udiv");
@(negedge clk); udiv_or=0;
comparisons=comparisons+1;
end endtask
task automatic run_sdiv(input integer index);
reg [162:0] held;
integer elapsed;
begin
@(negedge clk);
while (sdiv_ir !== 1'b1) @(negedge clk);
case(index)
0: begin sdiv_numerator=128'h00000000000000000000000000010000; sdiv_denominator=32'h00020000; end
1: begin sdiv_numerator=128'hffffffffffffffffffffffffffff0000; sdiv_denominator=32'h00020000; end
2: begin sdiv_numerator=128'h00000000000000000000000000020001; sdiv_denominator=32'h00020000; end
3: begin sdiv_numerator=128'hfffffffffffffffffffffffffffdffff; sdiv_denominator=32'h00020000; end
4: begin sdiv_numerator=128'h00000000000000000000000000020000; sdiv_denominator=32'h00020000; end
5: begin sdiv_numerator=128'hfffffffffffffffffffffffffffe0000; sdiv_denominator=32'h00020000; end
6: begin sdiv_numerator=128'h80000000000000000000000000000000; sdiv_denominator=32'h00020000; end
7: begin sdiv_numerator=128'h7fffffffffffffffffffffffffffffff; sdiv_denominator=32'h00020000; end
8: begin sdiv_numerator=128'h5261bba02aca50bde378834d8dd6b217; sdiv_denominator=32'hc41ab34f; end
9: begin sdiv_numerator=128'h504d6a026d34f915e737691b54c726df; sdiv_denominator=32'hacb3b00a; end
10: begin sdiv_numerator=128'h77ae5fd8ec8b435e96fbc425b3a00c4f; sdiv_denominator=32'hecc7bbc9; end
11: begin sdiv_numerator=128'h10123e7ce6d352ced08fbf4d605e2db7; sdiv_denominator=32'h479855c3; end
12: begin sdiv_numerator=128'h1fe42b1081236e34f425bcf460d3ec76; sdiv_denominator=32'h6fc72809; end
13: begin sdiv_numerator=128'h6d9fee7c2a23e9a6f82b922fa50cc039; sdiv_denominator=32'h3fc1e792; end
14: begin sdiv_numerator=128'h572b33ba061cab72195cfec05c473284; sdiv_denominator=32'h9374c6b1; end
15: begin sdiv_numerator=128'h01cf63d5242378d0575823123fc85a13; sdiv_denominator=32'hb8f48a1b; end
16: begin sdiv_numerator=128'hdab313aa5b037cf312f005ab107842f7; sdiv_denominator=32'h51938f4a; end
17: begin sdiv_numerator=128'h7f239ba48fd6822b7d24fde5990d49ec; sdiv_denominator=32'h66a55a2a; end
18: begin sdiv_numerator=128'h382437d0ed7ff3107659197107d485b5; sdiv_denominator=32'h16930ce6; end
19: begin sdiv_numerator=128'he45d23769720faf9fd0aa2cf399216f3; sdiv_denominator=32'h49e15828; end
20: begin sdiv_numerator=128'hbc9e1c492363086458df57bc2e97026a; sdiv_denominator=32'h3298a7ab; end
21: begin sdiv_numerator=128'hc13c23811d747d0ff4eced4fcff7a874; sdiv_denominator=32'hbc7cdabc; end
22: begin sdiv_numerator=128'heee52cede3e55e839fc78a4d1276c162; sdiv_denominator=32'ha7bc4453; end
23: begin sdiv_numerator=128'hc9ee9762780ef4a7dd4035901b614e1a; sdiv_denominator=32'h293bc9ec; end
24: begin sdiv_numerator=128'hc0a4051b46cdc3f206055bb5fd9998cd; sdiv_denominator=32'h36b058ec; end
25: begin sdiv_numerator=128'hfe9165c0abd99bbedb5c0f32b25a2ada; sdiv_denominator=32'hed82cdce; end
26: begin sdiv_numerator=128'hbde91022787cbdc729e32e68cc2fad81; sdiv_denominator=32'h86aa1e14; end
27: begin sdiv_numerator=128'hb9b23171255e966b63366954895b0a52; sdiv_denominator=32'hbbd6c847; end
28: begin sdiv_numerator=128'hd0fa694dc800fbef3de1d9b3d85fa4d9; sdiv_denominator=32'hd2f5527e; end
29: begin sdiv_numerator=128'hdc283891fae9034df0cb1ac6b29eceff; sdiv_denominator=32'h7425e6ee; end
30: begin sdiv_numerator=128'h7de3c3c84063c70b75cb620d03b761f5; sdiv_denominator=32'h2c26681f; end
31: begin sdiv_numerator=128'h1a7bc2df2ebb72ed6793a0b1e761e93f; sdiv_denominator=32'ha23f20aa; end
32: begin sdiv_numerator=128'hffffffffffffffffffffffffffffffff; sdiv_denominator=32'h00000000; end
default: $fatal(1,"BAD_CASE");
endcase
sdiv_iv=1; @(posedge clk);
if (sdiv_ir !== 1'b1) $fatal(1,"ACCEPT_sdiv");
#1; elapsed=0;
repeat (131) begin
if (sdiv_ov !== 1'b0) $fatal(1,"EARLY_VALID_sdiv edge=%0d",elapsed);
@(negedge clk); sdiv_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
if (sdiv_ov !== 1'b1) $fatal(1,"LATE_VALID_sdiv edge=%0d",elapsed);
case(index)
0: begin if (sdiv_quotient !== 129'h000000000000000000000000000000000) $fatal(1,"NUMERICAL_sdiv_quotient case=0 actual=%h expected=%h",sdiv_quotient,129'h000000000000000000000000000000000); if (sdiv_remainder !== 32'h00010000) $fatal(1,"NUMERICAL_sdiv_remainder case=0 actual=%h expected=%h",sdiv_remainder,32'h00010000); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=0 actual=%h expected=%h",sdiv_out_error,1'h0); end
1: begin if (sdiv_quotient !== 129'h000000000000000000000000000000000) $fatal(1,"NUMERICAL_sdiv_quotient case=1 actual=%h expected=%h",sdiv_quotient,129'h000000000000000000000000000000000); if (sdiv_remainder !== 32'h00010000) $fatal(1,"NUMERICAL_sdiv_remainder case=1 actual=%h expected=%h",sdiv_remainder,32'h00010000); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=1 actual=%h expected=%h",sdiv_out_error,1'h0); end
2: begin if (sdiv_quotient !== 129'h000000000000000000000000000000001) $fatal(1,"NUMERICAL_sdiv_quotient case=2 actual=%h expected=%h",sdiv_quotient,129'h000000000000000000000000000000001); if (sdiv_remainder !== 32'h00000001) $fatal(1,"NUMERICAL_sdiv_remainder case=2 actual=%h expected=%h",sdiv_remainder,32'h00000001); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=2 actual=%h expected=%h",sdiv_out_error,1'h0); end
3: begin if (sdiv_quotient !== 129'h1ffffffffffffffffffffffffffffffff) $fatal(1,"NUMERICAL_sdiv_quotient case=3 actual=%h expected=%h",sdiv_quotient,129'h1ffffffffffffffffffffffffffffffff); if (sdiv_remainder !== 32'h00000001) $fatal(1,"NUMERICAL_sdiv_remainder case=3 actual=%h expected=%h",sdiv_remainder,32'h00000001); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=3 actual=%h expected=%h",sdiv_out_error,1'h0); end
4: begin if (sdiv_quotient !== 129'h000000000000000000000000000000001) $fatal(1,"NUMERICAL_sdiv_quotient case=4 actual=%h expected=%h",sdiv_quotient,129'h000000000000000000000000000000001); if (sdiv_remainder !== 32'h00000000) $fatal(1,"NUMERICAL_sdiv_remainder case=4 actual=%h expected=%h",sdiv_remainder,32'h00000000); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=4 actual=%h expected=%h",sdiv_out_error,1'h0); end
5: begin if (sdiv_quotient !== 129'h1ffffffffffffffffffffffffffffffff) $fatal(1,"NUMERICAL_sdiv_quotient case=5 actual=%h expected=%h",sdiv_quotient,129'h1ffffffffffffffffffffffffffffffff); if (sdiv_remainder !== 32'h00000000) $fatal(1,"NUMERICAL_sdiv_remainder case=5 actual=%h expected=%h",sdiv_remainder,32'h00000000); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=5 actual=%h expected=%h",sdiv_out_error,1'h0); end
6: begin if (sdiv_quotient !== 129'h1ffffc000000000000000000000000000) $fatal(1,"NUMERICAL_sdiv_quotient case=6 actual=%h expected=%h",sdiv_quotient,129'h1ffffc000000000000000000000000000); if (sdiv_remainder !== 32'h00000000) $fatal(1,"NUMERICAL_sdiv_remainder case=6 actual=%h expected=%h",sdiv_remainder,32'h00000000); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=6 actual=%h expected=%h",sdiv_out_error,1'h0); end
7: begin if (sdiv_quotient !== 129'h000003fffffffffffffffffffffffffff) $fatal(1,"NUMERICAL_sdiv_quotient case=7 actual=%h expected=%h",sdiv_quotient,129'h000003fffffffffffffffffffffffffff); if (sdiv_remainder !== 32'h0001ffff) $fatal(1,"NUMERICAL_sdiv_remainder case=7 actual=%h expected=%h",sdiv_remainder,32'h0001ffff); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=7 actual=%h expected=%h",sdiv_out_error,1'h0); end
8: begin if (sdiv_quotient !== 129'h0000000006b8b1f91a0a522e10d688659) $fatal(1,"NUMERICAL_sdiv_quotient case=8 actual=%h expected=%h",sdiv_quotient,129'h0000000006b8b1f91a0a522e10d688659); if (sdiv_remainder !== 32'h8b9b01a0) $fatal(1,"NUMERICAL_sdiv_remainder case=8 actual=%h expected=%h",sdiv_remainder,32'h8b9b01a0); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=8 actual=%h expected=%h",sdiv_out_error,1'h0); end
9: begin if (sdiv_quotient !== 129'h0000000007708ba20332f4b441c474046) $fatal(1,"NUMERICAL_sdiv_quotient case=9 actual=%h expected=%h",sdiv_quotient,129'h0000000007708ba20332f4b441c474046); if (sdiv_remainder !== 32'h44dc8423) $fatal(1,"NUMERICAL_sdiv_remainder case=9 actual=%h expected=%h",sdiv_remainder,32'h44dc8423); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=9 actual=%h expected=%h",sdiv_out_error,1'h0); end
10: begin if (sdiv_quotient !== 129'h000000000816555dde4a1a9bbb6669bf2) $fatal(1,"NUMERICAL_sdiv_quotient case=10 actual=%h expected=%h",sdiv_quotient,129'h000000000816555dde4a1a9bbb6669bf2); if (sdiv_remainder !== 32'h3807d54d) $fatal(1,"NUMERICAL_sdiv_remainder case=10 actual=%h expected=%h",sdiv_remainder,32'h3807d54d); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=10 actual=%h expected=%h",sdiv_out_error,1'h0); end
11: begin if (sdiv_quotient !== 129'h000000000397729687b92d131815ab719) $fatal(1,"NUMERICAL_sdiv_quotient case=11 actual=%h expected=%h",sdiv_quotient,129'h000000000397729687b92d131815ab719); if (sdiv_remainder !== 32'h13a168ac) $fatal(1,"NUMERICAL_sdiv_remainder case=11 actual=%h expected=%h",sdiv_remainder,32'h13a168ac); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=11 actual=%h expected=%h",sdiv_out_error,1'h0); end
12: begin if (sdiv_quotient !== 129'h000000000490a0691e76b441e3a339c16) $fatal(1,"NUMERICAL_sdiv_quotient case=12 actual=%h expected=%h",sdiv_quotient,129'h000000000490a0691e76b441e3a339c16); if (sdiv_remainder !== 32'h6585ffb0) $fatal(1,"NUMERICAL_sdiv_remainder case=12 actual=%h expected=%h",sdiv_remainder,32'h6585ffb0); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=12 actual=%h expected=%h",sdiv_out_error,1'h0); end
13: begin if (sdiv_quotient !== 129'h000000001b82acb6a4d60176b96d90477) $fatal(1,"NUMERICAL_sdiv_quotient case=13 actual=%h expected=%h",sdiv_quotient,129'h000000001b82acb6a4d60176b96d90477); if (sdiv_remainder !== 32'h2389d35b) $fatal(1,"NUMERICAL_sdiv_remainder case=13 actual=%h expected=%h",sdiv_remainder,32'h2389d35b); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=13 actual=%h expected=%h",sdiv_out_error,1'h0); end
14: begin if (sdiv_quotient !== 129'h0000000009755a1090ae6910b566d5482) $fatal(1,"NUMERICAL_sdiv_quotient case=14 actual=%h expected=%h",sdiv_quotient,129'h0000000009755a1090ae6910b566d5482); if (sdiv_remainder !== 32'h1a6b38a2) $fatal(1,"NUMERICAL_sdiv_remainder case=14 actual=%h expected=%h",sdiv_remainder,32'h1a6b38a2); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=14 actual=%h expected=%h",sdiv_out_error,1'h0); end
15: begin if (sdiv_quotient !== 129'h0000000000281630110d835a13fea9ff9) $fatal(1,"NUMERICAL_sdiv_quotient case=15 actual=%h expected=%h",sdiv_quotient,129'h0000000000281630110d835a13fea9ff9); if (sdiv_remainder !== 32'h967940d0) $fatal(1,"NUMERICAL_sdiv_remainder case=15 actual=%h expected=%h",sdiv_remainder,32'h967940d0); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=15 actual=%h expected=%h",sdiv_out_error,1'h0); end
16: begin if (sdiv_quotient !== 129'h1ffffffff8af1eddeb209cbda54e7ece4) $fatal(1,"NUMERICAL_sdiv_quotient case=16 actual=%h expected=%h",sdiv_quotient,129'h1ffffffff8af1eddeb209cbda54e7ece4); if (sdiv_remainder !== 32'h32d192f1) $fatal(1,"NUMERICAL_sdiv_remainder case=16 actual=%h expected=%h",sdiv_remainder,32'h32d192f1); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=16 actual=%h expected=%h",sdiv_out_error,1'h0); end
17: begin if (sdiv_quotient !== 129'h0000000013d1615e88b9e8be8942f1752) $fatal(1,"NUMERICAL_sdiv_quotient case=17 actual=%h expected=%h",sdiv_quotient,129'h0000000013d1615e88b9e8be8942f1752); if (sdiv_remainder !== 32'h0746a278) $fatal(1,"NUMERICAL_sdiv_remainder case=17 actual=%h expected=%h",sdiv_remainder,32'h0746a278); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=17 actual=%h expected=%h",sdiv_out_error,1'h0); end
18: begin if (sdiv_quotient !== 129'h0000000027ca8da86343e04fd2356cbd3) $fatal(1,"NUMERICAL_sdiv_quotient case=18 actual=%h expected=%h",sdiv_quotient,129'h0000000027ca8da86343e04fd2356cbd3); if (sdiv_remainder !== 32'h0a228223) $fatal(1,"NUMERICAL_sdiv_remainder case=18 actual=%h expected=%h",sdiv_remainder,32'h0a228223); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=18 actual=%h expected=%h",sdiv_out_error,1'h0); end
19: begin if (sdiv_quotient !== 129'h1ffffffffa03d220caaeb40cd02e23482) $fatal(1,"NUMERICAL_sdiv_quotient case=19 actual=%h expected=%h",sdiv_quotient,129'h1ffffffffa03d220caaeb40cd02e23482); if (sdiv_remainder !== 32'h3414cd5d) $fatal(1,"NUMERICAL_sdiv_remainder case=19 actual=%h expected=%h",sdiv_remainder,32'h3414cd5d); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=19 actual=%h expected=%h",sdiv_out_error,1'h0); end
20: begin if (sdiv_quotient !== 129'h1fffffffeab1176d69d8acc0c5fc32487) $fatal(1,"NUMERICAL_sdiv_quotient case=20 actual=%h expected=%h",sdiv_quotient,129'h1fffffffeab1176d69d8acc0c5fc32487); if (sdiv_remainder !== 32'h23be74c3) $fatal(1,"NUMERICAL_sdiv_remainder case=20 actual=%h expected=%h",sdiv_remainder,32'h23be74c3); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=20 actual=%h expected=%h",sdiv_out_error,1'h0); end
21: begin if (sdiv_quotient !== 129'h1ffffffffaac0f903c69e39e3d5e32078) $fatal(1,"NUMERICAL_sdiv_quotient case=21 actual=%h expected=%h",sdiv_quotient,129'h1ffffffffaac0f903c69e39e3d5e32078); if (sdiv_remainder !== 32'h869a5fac) $fatal(1,"NUMERICAL_sdiv_remainder case=21 actual=%h expected=%h",sdiv_remainder,32'h869a5fac); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=21 actual=%h expected=%h",sdiv_out_error,1'h0); end
22: begin if (sdiv_quotient !== 129'h1ffffffffe5e4fb004f56d46c96ed9582) $fatal(1,"NUMERICAL_sdiv_quotient case=22 actual=%h expected=%h",sdiv_quotient,129'h1ffffffffe5e4fb004f56d46c96ed9582); if (sdiv_remainder !== 32'h91bf3fc4) $fatal(1,"NUMERICAL_sdiv_remainder case=22 actual=%h expected=%h",sdiv_remainder,32'h91bf3fc4); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=22 actual=%h expected=%h",sdiv_out_error,1'h0); end
23: begin if (sdiv_quotient !== 129'h1fffffffeb0511bdfa7aee3f62d977c4e) $fatal(1,"NUMERICAL_sdiv_quotient case=23 actual=%h expected=%h",sdiv_quotient,129'h1fffffffeb0511bdfa7aee3f62d977c4e); if (sdiv_remainder !== 32'h00d887ce) $fatal(1,"NUMERICAL_sdiv_remainder case=23 actual=%h expected=%h",sdiv_remainder,32'h00d887ce); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=23 actual=%h expected=%h",sdiv_out_error,1'h0); end
24: begin if (sdiv_quotient !== 129'h1fffffffed769d70bb0b43b571a7da0e3) $fatal(1,"NUMERICAL_sdiv_quotient case=24 actual=%h expected=%h",sdiv_quotient,129'h1fffffffed769d70bb0b43b571a7da0e3); if (sdiv_remainder !== 32'h1b94c077) $fatal(1,"NUMERICAL_sdiv_remainder case=24 actual=%h expected=%h",sdiv_remainder,32'h1b94c077); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=24 actual=%h expected=%h",sdiv_out_error,1'h0); end
25: begin if (sdiv_quotient !== 129'h1fffffffffe74dbfa32583992520cd95c) $fatal(1,"NUMERICAL_sdiv_quotient case=25 actual=%h expected=%h",sdiv_quotient,129'h1fffffffffe74dbfa32583992520cd95c); if (sdiv_remainder !== 32'h2ac3692e) $fatal(1,"NUMERICAL_sdiv_remainder case=25 actual=%h expected=%h",sdiv_remainder,32'h2ac3692e); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=25 actual=%h expected=%h",sdiv_out_error,1'h0); end
26: begin if (sdiv_quotient !== 129'h1ffffffff825cc18773cc228457e668a0) $fatal(1,"NUMERICAL_sdiv_quotient case=26 actual=%h expected=%h",sdiv_quotient,129'h1ffffffff825cc18773cc228457e668a0); if (sdiv_remainder !== 32'h4c533eff) $fatal(1,"NUMERICAL_sdiv_remainder case=26 actual=%h expected=%h",sdiv_remainder,32'h4c533eff); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=26 actual=%h expected=%h",sdiv_out_error,1'h0); end
27: begin if (sdiv_quotient !== 129'h1ffffffffa02f5760c69baf9a887027df) $fatal(1,"NUMERICAL_sdiv_quotient case=27 actual=%h expected=%h",sdiv_quotient,129'h1ffffffffa02f5760c69baf9a887027df); if (sdiv_remainder !== 32'h26503c87) $fatal(1,"NUMERICAL_sdiv_remainder case=27 actual=%h expected=%h",sdiv_remainder,32'h26503c87); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=27 actual=%h expected=%h",sdiv_out_error,1'h0); end
28: begin if (sdiv_quotient !== 129'h1ffffffffc6f043f6154bfb75f64d81eb) $fatal(1,"NUMERICAL_sdiv_quotient case=28 actual=%h expected=%h",sdiv_quotient,129'h1ffffffffc6f043f6154bfb75f64d81eb); if (sdiv_remainder !== 32'h514a92d1) $fatal(1,"NUMERICAL_sdiv_remainder case=28 actual=%h expected=%h",sdiv_remainder,32'h514a92d1); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=28 actual=%h expected=%h",sdiv_out_error,1'h0); end
29: begin if (sdiv_quotient !== 129'h1ffffffffb0ffd159027dea2fc78e9949) $fatal(1,"NUMERICAL_sdiv_quotient case=29 actual=%h expected=%h",sdiv_quotient,129'h1ffffffffb0ffd159027dea2fc78e9949); if (sdiv_remainder !== 32'h2d3848df) $fatal(1,"NUMERICAL_sdiv_remainder case=29 actual=%h expected=%h",sdiv_remainder,32'h2d3848df); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=29 actual=%h expected=%h",sdiv_out_error,1'h0); end
30: begin if (sdiv_quotient !== 129'h000000002d9f5d3c90a22a577d4e347aa) $fatal(1,"NUMERICAL_sdiv_quotient case=30 actual=%h expected=%h",sdiv_quotient,129'h000000002d9f5d3c90a22a577d4e347aa); if (sdiv_remainder !== 32'h0bd8a45f) $fatal(1,"NUMERICAL_sdiv_remainder case=30 actual=%h expected=%h",sdiv_remainder,32'h0bd8a45f); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=30 actual=%h expected=%h",sdiv_out_error,1'h0); end
31: begin if (sdiv_quotient !== 129'h00000000029c969d5aaef3d4edb14c544) $fatal(1,"NUMERICAL_sdiv_quotient case=31 actual=%h expected=%h",sdiv_quotient,129'h00000000029c969d5aaef3d4edb14c544); if (sdiv_remainder !== 32'h3f326a17) $fatal(1,"NUMERICAL_sdiv_remainder case=31 actual=%h expected=%h",sdiv_remainder,32'h3f326a17); if (sdiv_out_error !== 1'h0) $fatal(1,"NUMERICAL_sdiv_out_error case=31 actual=%h expected=%h",sdiv_out_error,1'h0); end
32: begin if (sdiv_out_error !== 1'h1) $fatal(1,"NUMERICAL_sdiv_out_error case=32 actual=%h expected=%h",sdiv_out_error,1'h1); end
endcase
held={1'b1,{sdiv_quotient,sdiv_remainder,sdiv_out_error}};
@(negedge clk); sdiv_iv=0;
repeat(3) begin @(posedge clk);
if ({sdiv_ov,{sdiv_quotient,sdiv_remainder,sdiv_out_error}} !== held) $fatal(1,"STALLED_sdiv");
#1;
if ({sdiv_ov,{sdiv_quotient,sdiv_remainder,sdiv_out_error}} !== held) $fatal(1,"STALLED_POST_sdiv");
end
@(negedge clk); sdiv_or=1; @(posedge clk); #1;
if (sdiv_ov !== 1'b0) $fatal(1,"RETIRE_sdiv");
@(negedge clk); sdiv_or=0;
comparisons=comparisons+1;
end endtask
task automatic run_root(input integer index);
reg [129:0] held;
integer elapsed;
begin
@(negedge clk);
while (root_ir !== 1'b1) @(negedge clk);
case(index)
0: begin root_radicand=128'h00000000000000000000000000000000; end
1: begin root_radicand=128'h00000000000000000000000000000001; end
2: begin root_radicand=128'h00000000000000000000000000000002; end
3: begin root_radicand=128'h00000000000000000000000000000003; end
4: begin root_radicand=128'h00000000000000000000000000000004; end
5: begin root_radicand=128'hffffffffffffffffffffffffffffffff; end
6: begin root_radicand=128'h0000000000000000000100000aaaaaaa; end
7: begin root_radicand=128'h00000000000000000001000000000000; end
8: begin root_radicand=128'h000000003fffffff8001000080000000; end
9: begin root_radicand=128'h000000000000000000010052c0000000; end
10: begin root_radicand=128'h00000000000000005f2d488b0aaaaaaa; end
11: begin root_radicand=128'h00000000000000000001005cd5555555; end
default: $fatal(1,"BAD_CASE");
endcase
root_iv=1; @(posedge clk);
if (root_ir !== 1'b1) $fatal(1,"ACCEPT_root");
#1; elapsed=0;
repeat (65) begin
if (root_ov !== 1'b0) $fatal(1,"EARLY_VALID_root edge=%0d",elapsed);
@(negedge clk); root_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
if (root_ov !== 1'b1) $fatal(1,"LATE_VALID_root edge=%0d",elapsed);
case(index)
0: begin if (root_root !== 64'h0000000000000000) $fatal(1,"NUMERICAL_root_root case=0 actual=%h expected=%h",root_root,64'h0000000000000000); if (root_remainder !== 65'h00000000000000000) $fatal(1,"NUMERICAL_root_remainder case=0 actual=%h expected=%h",root_remainder,65'h00000000000000000); end
1: begin if (root_root !== 64'h0000000000000001) $fatal(1,"NUMERICAL_root_root case=1 actual=%h expected=%h",root_root,64'h0000000000000001); if (root_remainder !== 65'h00000000000000000) $fatal(1,"NUMERICAL_root_remainder case=1 actual=%h expected=%h",root_remainder,65'h00000000000000000); end
2: begin if (root_root !== 64'h0000000000000001) $fatal(1,"NUMERICAL_root_root case=2 actual=%h expected=%h",root_root,64'h0000000000000001); if (root_remainder !== 65'h00000000000000001) $fatal(1,"NUMERICAL_root_remainder case=2 actual=%h expected=%h",root_remainder,65'h00000000000000001); end
3: begin if (root_root !== 64'h0000000000000001) $fatal(1,"NUMERICAL_root_root case=3 actual=%h expected=%h",root_root,64'h0000000000000001); if (root_remainder !== 65'h00000000000000002) $fatal(1,"NUMERICAL_root_remainder case=3 actual=%h expected=%h",root_remainder,65'h00000000000000002); end
4: begin if (root_root !== 64'h0000000000000002) $fatal(1,"NUMERICAL_root_root case=4 actual=%h expected=%h",root_root,64'h0000000000000002); if (root_remainder !== 65'h00000000000000000) $fatal(1,"NUMERICAL_root_remainder case=4 actual=%h expected=%h",root_remainder,65'h00000000000000000); end
5: begin if (root_root !== 64'hffffffffffffffff) $fatal(1,"NUMERICAL_root_root case=5 actual=%h expected=%h",root_root,64'hffffffffffffffff); if (root_remainder !== 65'h1fffffffffffffffe) $fatal(1,"NUMERICAL_root_remainder case=5 actual=%h expected=%h",root_remainder,65'h1fffffffffffffffe); end
6: begin if (root_root !== 64'h0000000001000005) $fatal(1,"NUMERICAL_root_root case=6 actual=%h expected=%h",root_root,64'h0000000001000005); if (root_remainder !== 65'h00000000000aaaa91) $fatal(1,"NUMERICAL_root_remainder case=6 actual=%h expected=%h",root_remainder,65'h00000000000aaaa91); end
7: begin if (root_root !== 64'h0000000001000000) $fatal(1,"NUMERICAL_root_root case=7 actual=%h expected=%h",root_root,64'h0000000001000000); if (root_remainder !== 65'h00000000000000000) $fatal(1,"NUMERICAL_root_remainder case=7 actual=%h expected=%h",root_remainder,65'h00000000000000000); end
8: begin if (root_root !== 64'h00007fffffff8001) $fatal(1,"NUMERICAL_root_root case=8 actual=%h expected=%h",root_root,64'h00007fffffff8001); if (root_remainder !== 65'h0000000004000ffff) $fatal(1,"NUMERICAL_root_remainder case=8 actual=%h expected=%h",root_remainder,65'h0000000004000ffff); end
9: begin if (root_root !== 64'h000000000100295c) $fatal(1,"NUMERICAL_root_root case=9 actual=%h expected=%h",root_root,64'h000000000100295c); if (root_remainder !== 65'h000000000015166f0) $fatal(1,"NUMERICAL_root_remainder case=9 actual=%h expected=%h",root_remainder,65'h000000000015166f0); end
10: begin if (root_root !== 64'h000000009c180529) $fatal(1,"NUMERICAL_root_root case=10 actual=%h expected=%h",root_root,64'h000000009c180529); if (root_remainder !== 65'h0000000001ae00a19) $fatal(1,"NUMERICAL_root_remainder case=10 actual=%h expected=%h",root_remainder,65'h0000000001ae00a19); end
11: begin if (root_root !== 64'h0000000001002e66) $fatal(1,"NUMERICAL_root_root case=11 actual=%h expected=%h",root_root,64'h0000000001002e66); if (root_remainder !== 65'h00000000000ec84b1) $fatal(1,"NUMERICAL_root_remainder case=11 actual=%h expected=%h",root_remainder,65'h00000000000ec84b1); end
endcase
held={1'b1,{root_root,root_remainder}};
@(negedge clk); root_iv=0;
repeat(3) begin @(posedge clk);
if ({root_ov,{root_root,root_remainder}} !== held) $fatal(1,"STALLED_root");
#1;
if ({root_ov,{root_root,root_remainder}} !== held) $fatal(1,"STALLED_POST_root");
end
@(negedge clk); root_or=1; @(posedge clk); #1;
if (root_ov !== 1'b0) $fatal(1,"RETIRE_root");
@(negedge clk); root_or=0;
comparisons=comparisons+1;
end endtask
task automatic run_add0(input integer index);
reg [129:0] held;
integer elapsed;
begin
@(negedge clk);
while (add0_ir !== 1'b1) @(negedge clk);
case(index)
0: begin add0_in_a=128'h00000000000000000000000000000000; add0_in_b=128'h00000000000000000000000000000000; end
1: begin add0_in_a=128'h7fffffffffffffffffffffffffffffff; add0_in_b=128'h00000000000000000000000000000001; end
2: begin add0_in_a=128'h80000000000000000000000000000000; add0_in_b=128'hffffffffffffffffffffffffffffffff; end
3: begin add0_in_a=128'h00000000ffffffffffffffffffffffff; add0_in_b=128'h00000000000000000000000000000001; end
4: begin add0_in_a=128'hffffffff000000000000000000000000; add0_in_b=128'hffffffffffffffffffffffffffffffff; end
5: begin add0_in_a=128'h773cdac559933a863444f5263ef53fb2; add0_in_b=128'h3e0e66fd0aca4133b0114a948b606602; end
6: begin add0_in_a=128'hd2cbc1dd35ebb4cc01a99f9ab6c15418; add0_in_b=128'h86e69f90fe4be359cb38905310340b6f; end
7: begin add0_in_a=128'hd5b0822d17c2c80dd97854fccfadf1aa; add0_in_b=128'h65eb43deef3ea65e07b15ce56fca2f4b; end
8: begin add0_in_a=128'hb55211d3389c8f4d713759fab20abf90; add0_in_b=128'h4ee30c20be7450056dcc86a5b7051422; end
9: begin add0_in_a=128'h6f379e26535c47b1e6e58ffd35a5265d; add0_in_b=128'hc073d38290dcf37bca8dac1227c9d631; end
10: begin add0_in_a=128'h26582d2f27986820be2d11b7d6e58a38; add0_in_b=128'h3c008bd42fdcfd30b32dd8e87d00432f; end
11: begin add0_in_a=128'ha9aa54fdbf5f2cef241de1e0db9e94ef; add0_in_b=128'h916c0f2219692e0ab1875cd6e9ea3ae5; end
12: begin add0_in_a=128'hb52c7b63899fe2f7260a30efb96ef164; add0_in_b=128'hd9a9a30a98d71ecde614380b6f487fb4; end
13: begin add0_in_a=128'haeca172c18a36c764a3c348088fc2ca1; add0_in_b=128'h0956b4a48f1e5781e8870c86a9c67107; end
14: begin add0_in_a=128'h8ffd697404fd518f77094069d3973276; add0_in_b=128'h4ff8867f33b688a8d9981adba82b99b7; end
15: begin add0_in_a=128'h6a98c3f8c69eca802a6277fba85aa71a; add0_in_b=128'h44e97689dc06dafd466147362ed9033e; end
16: begin add0_in_a=128'hbd4796b606fc943b32939b8b114b90bf; add0_in_b=128'he6f08176c09175943ad823e5d4cd76ed; end
17: begin add0_in_a=128'hcbaef9d3709cf128dd2b395bfe53ba6b; add0_in_b=128'h399ecc0e2e3a812d54c2b7c7f2410a07; end
18: begin add0_in_a=128'hafab8b976c197960aad9631dd4996532; add0_in_b=128'ha409281557306a6cbc84dfa0e7199414; end
19: begin add0_in_a=128'hd45ee74baa1307bb9eabe5cb4139b76f; add0_in_b=128'h8995441df775622d05cbc9e1dd62ef1d; end
20: begin add0_in_a=128'h9a99a42beeef9e400e7979e4dc90646d; add0_in_b=128'h554cdbe8d58530dc199baf7d5fa51fbc; end
21: begin add0_in_a=128'h389ebd0f0090dc10cb7990b0347179fb; add0_in_b=128'h0cc15380300aeabcacd4318cebdaa44d; end
22: begin add0_in_a=128'h87b1b3c72620e57815b687381f409bba; add0_in_b=128'h44e06e19e3f5ad7a2744f86224179496; end
23: begin add0_in_a=128'h2a706b8cc150d5d4f29218b8521ea27f; add0_in_b=128'hfd8e1c277eee3d3d8c088b0d06ac8734; end
24: begin add0_in_a=128'h50d957c0875eeab6866616db618e4495; add0_in_b=128'hc5de5175e40737e13fba8823804ee701; end
25: begin add0_in_a=128'ha18d93763ba8b319b40784867c0b736f; add0_in_b=128'h3e506c9af4c0b4e970d8bb10a9ef4c02; end
26: begin add0_in_a=128'h96e0a1e2ade0ae151fcf573e9a14ef9e; add0_in_b=128'h9c990bebb603d7a5c716af8527435641; end
27: begin add0_in_a=128'h6db03b07ce8172da2176e7d6c76a2850; add0_in_b=128'he9669785235c66fabc4d71a9313414dc; end
28: begin add0_in_a=128'hd34470ec0741757e36c46951f858c139; add0_in_b=128'h0a320976c2e8e3e244a027d343fd2449; end
29: begin add0_in_a=128'hdcb11ccc5e54434b4b690bb0b4eeb61a; add0_in_b=128'hac427cde575ba622c51d6ee82b2b7a1a; end
30: begin add0_in_a=128'h7a33a63d381e790f93a5175b65118409; add0_in_b=128'h14f4f05d833c4ed4b9aeaae1e1f9ad76; end
31: begin add0_in_a=128'h65134e6556ec706fe06a14055df7915d; add0_in_b=128'hf07f282034e3b07edb60a23574751cc9; end
32: begin add0_in_a=128'hd0952fb711ee58f9de21618f48e27401; add0_in_b=128'hadfcf8179e62ad660eedfc5c733df559; end
33: begin add0_in_a=128'hcd428edac5114db1dfdffd3bdfbc8030; add0_in_b=128'h9a60653bfa886b69d327858811941412; end
34: begin add0_in_a=128'h28ba50493f0aa5118d078fe848cd2015; add0_in_b=128'h55b3c0815d3b02f37c07563c66fc401e; end
35: begin add0_in_a=128'hfe38a6822414e5fb13fca63a23a55327; add0_in_b=128'h680e4752d0081f27c6f198a071ebf73a; end
36: begin add0_in_a=128'h34d147e622a4b4aa6b7761b032a87716; add0_in_b=128'h8b39a8e190d905a9d957cc5c5e0b5356; end
default: $fatal(1,"BAD_CASE");
endcase
add0_iv=1; @(posedge clk);
if (add0_ir !== 1'b1) $fatal(1,"ACCEPT_add0");
#1; elapsed=0;
repeat (3) begin
if (add0_ov !== 1'b0) $fatal(1,"EARLY_VALID_add0 edge=%0d",elapsed);
@(negedge clk); add0_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
if (add0_ov !== 1'b1) $fatal(1,"LATE_VALID_add0 edge=%0d",elapsed);
case(index)
0: begin if (add0_out_sum !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_add0_out_sum case=0 actual=%h expected=%h",add0_out_sum,128'h00000000000000000000000000000000); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=0 actual=%h expected=%h",add0_out_error,1'h0); end
1: begin if (add0_out_sum !== 128'h80000000000000000000000000000000) $fatal(1,"NUMERICAL_add0_out_sum case=1 actual=%h expected=%h",add0_out_sum,128'h80000000000000000000000000000000); if (add0_out_error !== 1'h1) $fatal(1,"NUMERICAL_add0_out_error case=1 actual=%h expected=%h",add0_out_error,1'h1); end
2: begin if (add0_out_sum !== 128'h7fffffffffffffffffffffffffffffff) $fatal(1,"NUMERICAL_add0_out_sum case=2 actual=%h expected=%h",add0_out_sum,128'h7fffffffffffffffffffffffffffffff); if (add0_out_error !== 1'h1) $fatal(1,"NUMERICAL_add0_out_error case=2 actual=%h expected=%h",add0_out_error,1'h1); end
3: begin if (add0_out_sum !== 128'h00000001000000000000000000000000) $fatal(1,"NUMERICAL_add0_out_sum case=3 actual=%h expected=%h",add0_out_sum,128'h00000001000000000000000000000000); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=3 actual=%h expected=%h",add0_out_error,1'h0); end
4: begin if (add0_out_sum !== 128'hfffffffeffffffffffffffffffffffff) $fatal(1,"NUMERICAL_add0_out_sum case=4 actual=%h expected=%h",add0_out_sum,128'hfffffffeffffffffffffffffffffffff); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=4 actual=%h expected=%h",add0_out_error,1'h0); end
5: begin if (add0_out_sum !== 128'hb54b41c2645d7bb9e4563fbaca55a5b4) $fatal(1,"NUMERICAL_add0_out_sum case=5 actual=%h expected=%h",add0_out_sum,128'hb54b41c2645d7bb9e4563fbaca55a5b4); if (add0_out_error !== 1'h1) $fatal(1,"NUMERICAL_add0_out_error case=5 actual=%h expected=%h",add0_out_error,1'h1); end
6: begin if (add0_out_sum !== 128'h59b2616e34379825cce22fedc6f55f87) $fatal(1,"NUMERICAL_add0_out_sum case=6 actual=%h expected=%h",add0_out_sum,128'h59b2616e34379825cce22fedc6f55f87); if (add0_out_error !== 1'h1) $fatal(1,"NUMERICAL_add0_out_error case=6 actual=%h expected=%h",add0_out_error,1'h1); end
7: begin if (add0_out_sum !== 128'h3b9bc60c07016e6be129b1e23f7820f5) $fatal(1,"NUMERICAL_add0_out_sum case=7 actual=%h expected=%h",add0_out_sum,128'h3b9bc60c07016e6be129b1e23f7820f5); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=7 actual=%h expected=%h",add0_out_error,1'h0); end
8: begin if (add0_out_sum !== 128'h04351df3f710df52df03e0a0690fd3b2) $fatal(1,"NUMERICAL_add0_out_sum case=8 actual=%h expected=%h",add0_out_sum,128'h04351df3f710df52df03e0a0690fd3b2); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=8 actual=%h expected=%h",add0_out_error,1'h0); end
9: begin if (add0_out_sum !== 128'h2fab71a8e4393b2db1733c0f5d6efc8e) $fatal(1,"NUMERICAL_add0_out_sum case=9 actual=%h expected=%h",add0_out_sum,128'h2fab71a8e4393b2db1733c0f5d6efc8e); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=9 actual=%h expected=%h",add0_out_error,1'h0); end
10: begin if (add0_out_sum !== 128'h6258b90357756551715aeaa053e5cd67) $fatal(1,"NUMERICAL_add0_out_sum case=10 actual=%h expected=%h",add0_out_sum,128'h6258b90357756551715aeaa053e5cd67); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=10 actual=%h expected=%h",add0_out_error,1'h0); end
11: begin if (add0_out_sum !== 128'h3b16641fd8c85af9d5a53eb7c588cfd4) $fatal(1,"NUMERICAL_add0_out_sum case=11 actual=%h expected=%h",add0_out_sum,128'h3b16641fd8c85af9d5a53eb7c588cfd4); if (add0_out_error !== 1'h1) $fatal(1,"NUMERICAL_add0_out_error case=11 actual=%h expected=%h",add0_out_error,1'h1); end
12: begin if (add0_out_sum !== 128'h8ed61e6e227701c50c1e68fb28b77118) $fatal(1,"NUMERICAL_add0_out_sum case=12 actual=%h expected=%h",add0_out_sum,128'h8ed61e6e227701c50c1e68fb28b77118); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=12 actual=%h expected=%h",add0_out_error,1'h0); end
13: begin if (add0_out_sum !== 128'hb820cbd0a7c1c3f832c3410732c29da8) $fatal(1,"NUMERICAL_add0_out_sum case=13 actual=%h expected=%h",add0_out_sum,128'hb820cbd0a7c1c3f832c3410732c29da8); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=13 actual=%h expected=%h",add0_out_error,1'h0); end
14: begin if (add0_out_sum !== 128'hdff5eff338b3da3850a15b457bc2cc2d) $fatal(1,"NUMERICAL_add0_out_sum case=14 actual=%h expected=%h",add0_out_sum,128'hdff5eff338b3da3850a15b457bc2cc2d); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=14 actual=%h expected=%h",add0_out_error,1'h0); end
15: begin if (add0_out_sum !== 128'haf823a82a2a5a57d70c3bf31d733aa58) $fatal(1,"NUMERICAL_add0_out_sum case=15 actual=%h expected=%h",add0_out_sum,128'haf823a82a2a5a57d70c3bf31d733aa58); if (add0_out_error !== 1'h1) $fatal(1,"NUMERICAL_add0_out_error case=15 actual=%h expected=%h",add0_out_error,1'h1); end
16: begin if (add0_out_sum !== 128'ha438182cc78e09cf6d6bbf70e61907ac) $fatal(1,"NUMERICAL_add0_out_sum case=16 actual=%h expected=%h",add0_out_sum,128'ha438182cc78e09cf6d6bbf70e61907ac); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=16 actual=%h expected=%h",add0_out_error,1'h0); end
17: begin if (add0_out_sum !== 128'h054dc5e19ed7725631edf123f094c472) $fatal(1,"NUMERICAL_add0_out_sum case=17 actual=%h expected=%h",add0_out_sum,128'h054dc5e19ed7725631edf123f094c472); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=17 actual=%h expected=%h",add0_out_error,1'h0); end
18: begin if (add0_out_sum !== 128'h53b4b3acc349e3cd675e42bebbb2f946) $fatal(1,"NUMERICAL_add0_out_sum case=18 actual=%h expected=%h",add0_out_sum,128'h53b4b3acc349e3cd675e42bebbb2f946); if (add0_out_error !== 1'h1) $fatal(1,"NUMERICAL_add0_out_error case=18 actual=%h expected=%h",add0_out_error,1'h1); end
19: begin if (add0_out_sum !== 128'h5df42b69a18869e8a477afad1e9ca68c) $fatal(1,"NUMERICAL_add0_out_sum case=19 actual=%h expected=%h",add0_out_sum,128'h5df42b69a18869e8a477afad1e9ca68c); if (add0_out_error !== 1'h1) $fatal(1,"NUMERICAL_add0_out_error case=19 actual=%h expected=%h",add0_out_error,1'h1); end
20: begin if (add0_out_sum !== 128'hefe68014c474cf1c281529623c358429) $fatal(1,"NUMERICAL_add0_out_sum case=20 actual=%h expected=%h",add0_out_sum,128'hefe68014c474cf1c281529623c358429); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=20 actual=%h expected=%h",add0_out_error,1'h0); end
21: begin if (add0_out_sum !== 128'h4560108f309bc6cd784dc23d204c1e48) $fatal(1,"NUMERICAL_add0_out_sum case=21 actual=%h expected=%h",add0_out_sum,128'h4560108f309bc6cd784dc23d204c1e48); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=21 actual=%h expected=%h",add0_out_error,1'h0); end
22: begin if (add0_out_sum !== 128'hcc9221e10a1692f23cfb7f9a43583050) $fatal(1,"NUMERICAL_add0_out_sum case=22 actual=%h expected=%h",add0_out_sum,128'hcc9221e10a1692f23cfb7f9a43583050); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=22 actual=%h expected=%h",add0_out_error,1'h0); end
23: begin if (add0_out_sum !== 128'h27fe87b4403f13127e9aa3c558cb29b3) $fatal(1,"NUMERICAL_add0_out_sum case=23 actual=%h expected=%h",add0_out_sum,128'h27fe87b4403f13127e9aa3c558cb29b3); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=23 actual=%h expected=%h",add0_out_error,1'h0); end
24: begin if (add0_out_sum !== 128'h16b7a9366b662297c6209efee1dd2b96) $fatal(1,"NUMERICAL_add0_out_sum case=24 actual=%h expected=%h",add0_out_sum,128'h16b7a9366b662297c6209efee1dd2b96); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=24 actual=%h expected=%h",add0_out_error,1'h0); end
25: begin if (add0_out_sum !== 128'hdfde00113069680324e03f9725fabf71) $fatal(1,"NUMERICAL_add0_out_sum case=25 actual=%h expected=%h",add0_out_sum,128'hdfde00113069680324e03f9725fabf71); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=25 actual=%h expected=%h",add0_out_error,1'h0); end
26: begin if (add0_out_sum !== 128'h3379adce63e485bae6e606c3c15845df) $fatal(1,"NUMERICAL_add0_out_sum case=26 actual=%h expected=%h",add0_out_sum,128'h3379adce63e485bae6e606c3c15845df); if (add0_out_error !== 1'h1) $fatal(1,"NUMERICAL_add0_out_error case=26 actual=%h expected=%h",add0_out_error,1'h1); end
27: begin if (add0_out_sum !== 128'h5716d28cf1ddd9d4ddc4597ff89e3d2c) $fatal(1,"NUMERICAL_add0_out_sum case=27 actual=%h expected=%h",add0_out_sum,128'h5716d28cf1ddd9d4ddc4597ff89e3d2c); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=27 actual=%h expected=%h",add0_out_error,1'h0); end
28: begin if (add0_out_sum !== 128'hdd767a62ca2a59607b6491253c55e582) $fatal(1,"NUMERICAL_add0_out_sum case=28 actual=%h expected=%h",add0_out_sum,128'hdd767a62ca2a59607b6491253c55e582); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=28 actual=%h expected=%h",add0_out_error,1'h0); end
29: begin if (add0_out_sum !== 128'h88f399aab5afe96e10867a98e01a3034) $fatal(1,"NUMERICAL_add0_out_sum case=29 actual=%h expected=%h",add0_out_sum,128'h88f399aab5afe96e10867a98e01a3034); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=29 actual=%h expected=%h",add0_out_error,1'h0); end
30: begin if (add0_out_sum !== 128'h8f28969abb5ac7e44d53c23d470b317f) $fatal(1,"NUMERICAL_add0_out_sum case=30 actual=%h expected=%h",add0_out_sum,128'h8f28969abb5ac7e44d53c23d470b317f); if (add0_out_error !== 1'h1) $fatal(1,"NUMERICAL_add0_out_error case=30 actual=%h expected=%h",add0_out_error,1'h1); end
31: begin if (add0_out_sum !== 128'h559276858bd020eebbcab63ad26cae26) $fatal(1,"NUMERICAL_add0_out_sum case=31 actual=%h expected=%h",add0_out_sum,128'h559276858bd020eebbcab63ad26cae26); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=31 actual=%h expected=%h",add0_out_error,1'h0); end
32: begin if (add0_out_sum !== 128'h7e9227ceb051065fed0f5debbc20695a) $fatal(1,"NUMERICAL_add0_out_sum case=32 actual=%h expected=%h",add0_out_sum,128'h7e9227ceb051065fed0f5debbc20695a); if (add0_out_error !== 1'h1) $fatal(1,"NUMERICAL_add0_out_error case=32 actual=%h expected=%h",add0_out_error,1'h1); end
33: begin if (add0_out_sum !== 128'h67a2f416bf99b91bb30782c3f1509442) $fatal(1,"NUMERICAL_add0_out_sum case=33 actual=%h expected=%h",add0_out_sum,128'h67a2f416bf99b91bb30782c3f1509442); if (add0_out_error !== 1'h1) $fatal(1,"NUMERICAL_add0_out_error case=33 actual=%h expected=%h",add0_out_error,1'h1); end
34: begin if (add0_out_sum !== 128'h7e6e10ca9c45a805090ee624afc96033) $fatal(1,"NUMERICAL_add0_out_sum case=34 actual=%h expected=%h",add0_out_sum,128'h7e6e10ca9c45a805090ee624afc96033); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=34 actual=%h expected=%h",add0_out_error,1'h0); end
35: begin if (add0_out_sum !== 128'h6646edd4f41d0522daee3eda95914a61) $fatal(1,"NUMERICAL_add0_out_sum case=35 actual=%h expected=%h",add0_out_sum,128'h6646edd4f41d0522daee3eda95914a61); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=35 actual=%h expected=%h",add0_out_error,1'h0); end
36: begin if (add0_out_sum !== 128'hc00af0c7b37dba5444cf2e0c90b3ca6c) $fatal(1,"NUMERICAL_add0_out_sum case=36 actual=%h expected=%h",add0_out_sum,128'hc00af0c7b37dba5444cf2e0c90b3ca6c); if (add0_out_error !== 1'h0) $fatal(1,"NUMERICAL_add0_out_error case=36 actual=%h expected=%h",add0_out_error,1'h0); end
endcase
held={1'b1,{add0_out_sum,add0_out_error}};
@(negedge clk); add0_iv=0;
repeat(3) begin @(posedge clk);
if ({add0_ov,{add0_out_sum,add0_out_error}} !== held) $fatal(1,"STALLED_add0");
#1;
if ({add0_ov,{add0_out_sum,add0_out_error}} !== held) $fatal(1,"STALLED_POST_add0");
end
@(negedge clk); add0_or=1; @(posedge clk); #1;
if (add0_ov !== 1'b0) $fatal(1,"RETIRE_add0");
@(negedge clk); add0_or=0;
comparisons=comparisons+1;
end endtask
task automatic run_add1(input integer index);
reg [129:0] held;
integer elapsed;
begin
@(negedge clk);
while (add1_ir !== 1'b1) @(negedge clk);
case(index)
0: begin add1_in_a=128'h00000000000000000000000000000000; add1_in_b=128'h00000000000000000000000000000000; end
1: begin add1_in_a=128'h7fffffffffffffffffffffffffffffff; add1_in_b=128'h00000000000000000000000000000001; end
2: begin add1_in_a=128'h80000000000000000000000000000000; add1_in_b=128'hffffffffffffffffffffffffffffffff; end
3: begin add1_in_a=128'h00000000ffffffffffffffffffffffff; add1_in_b=128'h00000000000000000000000000000001; end
4: begin add1_in_a=128'hffffffff000000000000000000000000; add1_in_b=128'hffffffffffffffffffffffffffffffff; end
5: begin add1_in_a=128'h773cdac559933a863444f5263ef53fb2; add1_in_b=128'h3e0e66fd0aca4133b0114a948b606602; end
6: begin add1_in_a=128'hd2cbc1dd35ebb4cc01a99f9ab6c15418; add1_in_b=128'h86e69f90fe4be359cb38905310340b6f; end
7: begin add1_in_a=128'hd5b0822d17c2c80dd97854fccfadf1aa; add1_in_b=128'h65eb43deef3ea65e07b15ce56fca2f4b; end
8: begin add1_in_a=128'hb55211d3389c8f4d713759fab20abf90; add1_in_b=128'h4ee30c20be7450056dcc86a5b7051422; end
9: begin add1_in_a=128'h6f379e26535c47b1e6e58ffd35a5265d; add1_in_b=128'hc073d38290dcf37bca8dac1227c9d631; end
10: begin add1_in_a=128'h26582d2f27986820be2d11b7d6e58a38; add1_in_b=128'h3c008bd42fdcfd30b32dd8e87d00432f; end
11: begin add1_in_a=128'ha9aa54fdbf5f2cef241de1e0db9e94ef; add1_in_b=128'h916c0f2219692e0ab1875cd6e9ea3ae5; end
12: begin add1_in_a=128'hb52c7b63899fe2f7260a30efb96ef164; add1_in_b=128'hd9a9a30a98d71ecde614380b6f487fb4; end
13: begin add1_in_a=128'haeca172c18a36c764a3c348088fc2ca1; add1_in_b=128'h0956b4a48f1e5781e8870c86a9c67107; end
14: begin add1_in_a=128'h8ffd697404fd518f77094069d3973276; add1_in_b=128'h4ff8867f33b688a8d9981adba82b99b7; end
15: begin add1_in_a=128'h6a98c3f8c69eca802a6277fba85aa71a; add1_in_b=128'h44e97689dc06dafd466147362ed9033e; end
16: begin add1_in_a=128'hbd4796b606fc943b32939b8b114b90bf; add1_in_b=128'he6f08176c09175943ad823e5d4cd76ed; end
17: begin add1_in_a=128'hcbaef9d3709cf128dd2b395bfe53ba6b; add1_in_b=128'h399ecc0e2e3a812d54c2b7c7f2410a07; end
18: begin add1_in_a=128'hafab8b976c197960aad9631dd4996532; add1_in_b=128'ha409281557306a6cbc84dfa0e7199414; end
19: begin add1_in_a=128'hd45ee74baa1307bb9eabe5cb4139b76f; add1_in_b=128'h8995441df775622d05cbc9e1dd62ef1d; end
20: begin add1_in_a=128'h9a99a42beeef9e400e7979e4dc90646d; add1_in_b=128'h554cdbe8d58530dc199baf7d5fa51fbc; end
21: begin add1_in_a=128'h389ebd0f0090dc10cb7990b0347179fb; add1_in_b=128'h0cc15380300aeabcacd4318cebdaa44d; end
22: begin add1_in_a=128'h87b1b3c72620e57815b687381f409bba; add1_in_b=128'h44e06e19e3f5ad7a2744f86224179496; end
23: begin add1_in_a=128'h2a706b8cc150d5d4f29218b8521ea27f; add1_in_b=128'hfd8e1c277eee3d3d8c088b0d06ac8734; end
24: begin add1_in_a=128'h50d957c0875eeab6866616db618e4495; add1_in_b=128'hc5de5175e40737e13fba8823804ee701; end
25: begin add1_in_a=128'ha18d93763ba8b319b40784867c0b736f; add1_in_b=128'h3e506c9af4c0b4e970d8bb10a9ef4c02; end
26: begin add1_in_a=128'h96e0a1e2ade0ae151fcf573e9a14ef9e; add1_in_b=128'h9c990bebb603d7a5c716af8527435641; end
27: begin add1_in_a=128'h6db03b07ce8172da2176e7d6c76a2850; add1_in_b=128'he9669785235c66fabc4d71a9313414dc; end
28: begin add1_in_a=128'hd34470ec0741757e36c46951f858c139; add1_in_b=128'h0a320976c2e8e3e244a027d343fd2449; end
29: begin add1_in_a=128'hdcb11ccc5e54434b4b690bb0b4eeb61a; add1_in_b=128'hac427cde575ba622c51d6ee82b2b7a1a; end
30: begin add1_in_a=128'h7a33a63d381e790f93a5175b65118409; add1_in_b=128'h14f4f05d833c4ed4b9aeaae1e1f9ad76; end
31: begin add1_in_a=128'h65134e6556ec706fe06a14055df7915d; add1_in_b=128'hf07f282034e3b07edb60a23574751cc9; end
32: begin add1_in_a=128'hd0952fb711ee58f9de21618f48e27401; add1_in_b=128'hadfcf8179e62ad660eedfc5c733df559; end
33: begin add1_in_a=128'hcd428edac5114db1dfdffd3bdfbc8030; add1_in_b=128'h9a60653bfa886b69d327858811941412; end
34: begin add1_in_a=128'h28ba50493f0aa5118d078fe848cd2015; add1_in_b=128'h55b3c0815d3b02f37c07563c66fc401e; end
35: begin add1_in_a=128'hfe38a6822414e5fb13fca63a23a55327; add1_in_b=128'h680e4752d0081f27c6f198a071ebf73a; end
36: begin add1_in_a=128'h34d147e622a4b4aa6b7761b032a87716; add1_in_b=128'h8b39a8e190d905a9d957cc5c5e0b5356; end
default: $fatal(1,"BAD_CASE");
endcase
add1_iv=1; @(posedge clk);
if (add1_ir !== 1'b1) $fatal(1,"ACCEPT_add1");
#1; elapsed=0;
repeat (3) begin
if (add1_ov !== 1'b0) $fatal(1,"EARLY_VALID_add1 edge=%0d",elapsed);
@(negedge clk); add1_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
if (add1_ov !== 1'b1) $fatal(1,"LATE_VALID_add1 edge=%0d",elapsed);
case(index)
0: begin if (add1_out_sum !== 128'h00000000000000000000000000000000) $fatal(1,"NUMERICAL_add1_out_sum case=0 actual=%h expected=%h",add1_out_sum,128'h00000000000000000000000000000000); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=0 actual=%h expected=%h",add1_out_error,1'h0); end
1: begin if (add1_out_sum !== 128'h7ffffffffffffffffffffffffffffffe) $fatal(1,"NUMERICAL_add1_out_sum case=1 actual=%h expected=%h",add1_out_sum,128'h7ffffffffffffffffffffffffffffffe); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=1 actual=%h expected=%h",add1_out_error,1'h0); end
2: begin if (add1_out_sum !== 128'h80000000000000000000000000000001) $fatal(1,"NUMERICAL_add1_out_sum case=2 actual=%h expected=%h",add1_out_sum,128'h80000000000000000000000000000001); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=2 actual=%h expected=%h",add1_out_error,1'h0); end
3: begin if (add1_out_sum !== 128'h00000000fffffffffffffffffffffffe) $fatal(1,"NUMERICAL_add1_out_sum case=3 actual=%h expected=%h",add1_out_sum,128'h00000000fffffffffffffffffffffffe); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=3 actual=%h expected=%h",add1_out_error,1'h0); end
4: begin if (add1_out_sum !== 128'hffffffff000000000000000000000001) $fatal(1,"NUMERICAL_add1_out_sum case=4 actual=%h expected=%h",add1_out_sum,128'hffffffff000000000000000000000001); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=4 actual=%h expected=%h",add1_out_error,1'h0); end
5: begin if (add1_out_sum !== 128'h392e73c84ec8f9528433aa91b394d9b0) $fatal(1,"NUMERICAL_add1_out_sum case=5 actual=%h expected=%h",add1_out_sum,128'h392e73c84ec8f9528433aa91b394d9b0); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=5 actual=%h expected=%h",add1_out_error,1'h0); end
6: begin if (add1_out_sum !== 128'h4be5224c379fd17236710f47a68d48a9) $fatal(1,"NUMERICAL_add1_out_sum case=6 actual=%h expected=%h",add1_out_sum,128'h4be5224c379fd17236710f47a68d48a9); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=6 actual=%h expected=%h",add1_out_error,1'h0); end
7: begin if (add1_out_sum !== 128'h6fc53e4e288421afd1c6f8175fe3c25f) $fatal(1,"NUMERICAL_add1_out_sum case=7 actual=%h expected=%h",add1_out_sum,128'h6fc53e4e288421afd1c6f8175fe3c25f); if (add1_out_error !== 1'h1) $fatal(1,"NUMERICAL_add1_out_error case=7 actual=%h expected=%h",add1_out_error,1'h1); end
8: begin if (add1_out_sum !== 128'h666f05b27a283f48036ad354fb05ab6e) $fatal(1,"NUMERICAL_add1_out_sum case=8 actual=%h expected=%h",add1_out_sum,128'h666f05b27a283f48036ad354fb05ab6e); if (add1_out_error !== 1'h1) $fatal(1,"NUMERICAL_add1_out_error case=8 actual=%h expected=%h",add1_out_error,1'h1); end
9: begin if (add1_out_sum !== 128'haec3caa3c27f54361c57e3eb0ddb502c) $fatal(1,"NUMERICAL_add1_out_sum case=9 actual=%h expected=%h",add1_out_sum,128'haec3caa3c27f54361c57e3eb0ddb502c); if (add1_out_error !== 1'h1) $fatal(1,"NUMERICAL_add1_out_error case=9 actual=%h expected=%h",add1_out_error,1'h1); end
10: begin if (add1_out_sum !== 128'hea57a15af7bb6af00aff38cf59e54709) $fatal(1,"NUMERICAL_add1_out_sum case=10 actual=%h expected=%h",add1_out_sum,128'hea57a15af7bb6af00aff38cf59e54709); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=10 actual=%h expected=%h",add1_out_error,1'h0); end
11: begin if (add1_out_sum !== 128'h183e45dba5f5fee472968509f1b45a0a) $fatal(1,"NUMERICAL_add1_out_sum case=11 actual=%h expected=%h",add1_out_sum,128'h183e45dba5f5fee472968509f1b45a0a); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=11 actual=%h expected=%h",add1_out_error,1'h0); end
12: begin if (add1_out_sum !== 128'hdb82d858f0c8c4293ff5f8e44a2671b0) $fatal(1,"NUMERICAL_add1_out_sum case=12 actual=%h expected=%h",add1_out_sum,128'hdb82d858f0c8c4293ff5f8e44a2671b0); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=12 actual=%h expected=%h",add1_out_error,1'h0); end
13: begin if (add1_out_sum !== 128'ha5736287898514f461b527f9df35bb9a) $fatal(1,"NUMERICAL_add1_out_sum case=13 actual=%h expected=%h",add1_out_sum,128'ha5736287898514f461b527f9df35bb9a); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=13 actual=%h expected=%h",add1_out_error,1'h0); end
14: begin if (add1_out_sum !== 128'h4004e2f4d146c8e69d71258e2b6b98bf) $fatal(1,"NUMERICAL_add1_out_sum case=14 actual=%h expected=%h",add1_out_sum,128'h4004e2f4d146c8e69d71258e2b6b98bf); if (add1_out_error !== 1'h1) $fatal(1,"NUMERICAL_add1_out_error case=14 actual=%h expected=%h",add1_out_error,1'h1); end
15: begin if (add1_out_sum !== 128'h25af4d6eea97ef82e40130c57981a3dc) $fatal(1,"NUMERICAL_add1_out_sum case=15 actual=%h expected=%h",add1_out_sum,128'h25af4d6eea97ef82e40130c57981a3dc); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=15 actual=%h expected=%h",add1_out_error,1'h0); end
16: begin if (add1_out_sum !== 128'hd657153f466b1ea6f7bb77a53c7e19d2) $fatal(1,"NUMERICAL_add1_out_sum case=16 actual=%h expected=%h",add1_out_sum,128'hd657153f466b1ea6f7bb77a53c7e19d2); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=16 actual=%h expected=%h",add1_out_error,1'h0); end
17: begin if (add1_out_sum !== 128'h92102dc542626ffb886881940c12b064) $fatal(1,"NUMERICAL_add1_out_sum case=17 actual=%h expected=%h",add1_out_sum,128'h92102dc542626ffb886881940c12b064); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=17 actual=%h expected=%h",add1_out_error,1'h0); end
18: begin if (add1_out_sum !== 128'h0ba2638214e90ef3ee54837ced7fd11e) $fatal(1,"NUMERICAL_add1_out_sum case=18 actual=%h expected=%h",add1_out_sum,128'h0ba2638214e90ef3ee54837ced7fd11e); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=18 actual=%h expected=%h",add1_out_error,1'h0); end
19: begin if (add1_out_sum !== 128'h4ac9a32db29da58e98e01be963d6c852) $fatal(1,"NUMERICAL_add1_out_sum case=19 actual=%h expected=%h",add1_out_sum,128'h4ac9a32db29da58e98e01be963d6c852); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=19 actual=%h expected=%h",add1_out_error,1'h0); end
20: begin if (add1_out_sum !== 128'h454cc843196a6d63f4ddca677ceb44b1) $fatal(1,"NUMERICAL_add1_out_sum case=20 actual=%h expected=%h",add1_out_sum,128'h454cc843196a6d63f4ddca677ceb44b1); if (add1_out_error !== 1'h1) $fatal(1,"NUMERICAL_add1_out_error case=20 actual=%h expected=%h",add1_out_error,1'h1); end
21: begin if (add1_out_sum !== 128'h2bdd698ed085f1541ea55f234896d5ae) $fatal(1,"NUMERICAL_add1_out_sum case=21 actual=%h expected=%h",add1_out_sum,128'h2bdd698ed085f1541ea55f234896d5ae); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=21 actual=%h expected=%h",add1_out_error,1'h0); end
22: begin if (add1_out_sum !== 128'h42d145ad422b37fdee718ed5fb290724) $fatal(1,"NUMERICAL_add1_out_sum case=22 actual=%h expected=%h",add1_out_sum,128'h42d145ad422b37fdee718ed5fb290724); if (add1_out_error !== 1'h1) $fatal(1,"NUMERICAL_add1_out_error case=22 actual=%h expected=%h",add1_out_error,1'h1); end
23: begin if (add1_out_sum !== 128'h2ce24f654262989766898dab4b721b4b) $fatal(1,"NUMERICAL_add1_out_sum case=23 actual=%h expected=%h",add1_out_sum,128'h2ce24f654262989766898dab4b721b4b); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=23 actual=%h expected=%h",add1_out_error,1'h0); end
24: begin if (add1_out_sum !== 128'h8afb064aa357b2d546ab8eb7e13f5d94) $fatal(1,"NUMERICAL_add1_out_sum case=24 actual=%h expected=%h",add1_out_sum,128'h8afb064aa357b2d546ab8eb7e13f5d94); if (add1_out_error !== 1'h1) $fatal(1,"NUMERICAL_add1_out_error case=24 actual=%h expected=%h",add1_out_error,1'h1); end
25: begin if (add1_out_sum !== 128'h633d26db46e7fe30432ec975d21c276d) $fatal(1,"NUMERICAL_add1_out_sum case=25 actual=%h expected=%h",add1_out_sum,128'h633d26db46e7fe30432ec975d21c276d); if (add1_out_error !== 1'h1) $fatal(1,"NUMERICAL_add1_out_error case=25 actual=%h expected=%h",add1_out_error,1'h1); end
26: begin if (add1_out_sum !== 128'hfa4795f6f7dcd66f58b8a7b972d1995d) $fatal(1,"NUMERICAL_add1_out_sum case=26 actual=%h expected=%h",add1_out_sum,128'hfa4795f6f7dcd66f58b8a7b972d1995d); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=26 actual=%h expected=%h",add1_out_error,1'h0); end
27: begin if (add1_out_sum !== 128'h8449a382ab250bdf6529762d96361374) $fatal(1,"NUMERICAL_add1_out_sum case=27 actual=%h expected=%h",add1_out_sum,128'h8449a382ab250bdf6529762d96361374); if (add1_out_error !== 1'h1) $fatal(1,"NUMERICAL_add1_out_error case=27 actual=%h expected=%h",add1_out_error,1'h1); end
28: begin if (add1_out_sum !== 128'hc91267754458919bf224417eb45b9cf0) $fatal(1,"NUMERICAL_add1_out_sum case=28 actual=%h expected=%h",add1_out_sum,128'hc91267754458919bf224417eb45b9cf0); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=28 actual=%h expected=%h",add1_out_error,1'h0); end
29: begin if (add1_out_sum !== 128'h306e9fee06f89d28864b9cc889c33c00) $fatal(1,"NUMERICAL_add1_out_sum case=29 actual=%h expected=%h",add1_out_sum,128'h306e9fee06f89d28864b9cc889c33c00); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=29 actual=%h expected=%h",add1_out_error,1'h0); end
30: begin if (add1_out_sum !== 128'h653eb5dfb4e22a3ad9f66c798317d693) $fatal(1,"NUMERICAL_add1_out_sum case=30 actual=%h expected=%h",add1_out_sum,128'h653eb5dfb4e22a3ad9f66c798317d693); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=30 actual=%h expected=%h",add1_out_error,1'h0); end
31: begin if (add1_out_sum !== 128'h749426452208bff1050971cfe9827494) $fatal(1,"NUMERICAL_add1_out_sum case=31 actual=%h expected=%h",add1_out_sum,128'h749426452208bff1050971cfe9827494); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=31 actual=%h expected=%h",add1_out_error,1'h0); end
32: begin if (add1_out_sum !== 128'h2298379f738bab93cf336532d5a47ea8) $fatal(1,"NUMERICAL_add1_out_sum case=32 actual=%h expected=%h",add1_out_sum,128'h2298379f738bab93cf336532d5a47ea8); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=32 actual=%h expected=%h",add1_out_error,1'h0); end
33: begin if (add1_out_sum !== 128'h32e2299eca88e2480cb877b3ce286c1e) $fatal(1,"NUMERICAL_add1_out_sum case=33 actual=%h expected=%h",add1_out_sum,128'h32e2299eca88e2480cb877b3ce286c1e); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=33 actual=%h expected=%h",add1_out_error,1'h0); end
34: begin if (add1_out_sum !== 128'hd3068fc7e1cfa21e110039abe1d0dff7) $fatal(1,"NUMERICAL_add1_out_sum case=34 actual=%h expected=%h",add1_out_sum,128'hd3068fc7e1cfa21e110039abe1d0dff7); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=34 actual=%h expected=%h",add1_out_error,1'h0); end
35: begin if (add1_out_sum !== 128'h962a5f2f540cc6d34d0b0d99b1b95bed) $fatal(1,"NUMERICAL_add1_out_sum case=35 actual=%h expected=%h",add1_out_sum,128'h962a5f2f540cc6d34d0b0d99b1b95bed); if (add1_out_error !== 1'h0) $fatal(1,"NUMERICAL_add1_out_error case=35 actual=%h expected=%h",add1_out_error,1'h0); end
36: begin if (add1_out_sum !== 128'ha9979f0491cbaf00921f9553d49d23c0) $fatal(1,"NUMERICAL_add1_out_sum case=36 actual=%h expected=%h",add1_out_sum,128'ha9979f0491cbaf00921f9553d49d23c0); if (add1_out_error !== 1'h1) $fatal(1,"NUMERICAL_add1_out_error case=36 actual=%h expected=%h",add1_out_error,1'h1); end
endcase
held={1'b1,{add1_out_sum,add1_out_error}};
@(negedge clk); add1_iv=0;
repeat(3) begin @(posedge clk);
if ({add1_ov,{add1_out_sum,add1_out_error}} !== held) $fatal(1,"STALLED_add1");
#1;
if ({add1_ov,{add1_out_sum,add1_out_error}} !== held) $fatal(1,"STALLED_POST_add1");
end
@(negedge clk); add1_or=1; @(posedge clk); #1;
if (add1_ov !== 1'b0) $fatal(1,"RETIRE_add1");
@(negedge clk); add1_or=0;
comparisons=comparisons+1;
end endtask
task automatic run_round0(input integer index);
reg [32:0] held;
integer elapsed;
begin
@(negedge clk);
while (round0_ir !== 1'b1) @(negedge clk);
case(index)
0: begin round0_in_value=128'h00000000000000000000000000000000; end
1: begin round0_in_value=128'h80000000000000000000000000000000; end
2: begin round0_in_value=128'h7fffffffffffffffffffffffffffffff; end
default: $fatal(1,"BAD_CASE");
endcase
round0_iv=1; @(posedge clk);
if (round0_ir !== 1'b1) $fatal(1,"ACCEPT_round0");
#1; elapsed=0;
repeat (0) begin
if (round0_ov !== 1'b0) $fatal(1,"EARLY_VALID_round0 edge=%0d",elapsed);
@(negedge clk); round0_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
if (round0_ov !== 1'b1) $fatal(1,"LATE_VALID_round0 edge=%0d",elapsed);
case(index)
0: begin if (round0_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round0_out_value case=0 actual=%h expected=%h",round0_out_value,32'h00000000); end
1: begin if (round0_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round0_out_value case=1 actual=%h expected=%h",round0_out_value,32'h80000000); end
2: begin if (round0_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round0_out_value case=2 actual=%h expected=%h",round0_out_value,32'h7fffffff); end
endcase
held={1'b1,{round0_out_value}};
@(negedge clk); round0_iv=0;
repeat(3) begin @(posedge clk);
if ({round0_ov,{round0_out_value}} !== held) $fatal(1,"STALLED_round0");
#1;
if ({round0_ov,{round0_out_value}} !== held) $fatal(1,"STALLED_POST_round0");
end
@(negedge clk); round0_or=1; @(posedge clk); #1;
if (round0_ov !== 1'b0) $fatal(1,"RETIRE_round0");
@(negedge clk); round0_or=0;
comparisons=comparisons+1;
end endtask
task automatic run_round16(input integer index);
reg [32:0] held;
integer elapsed;
begin
@(negedge clk);
while (round16_ir !== 1'b1) @(negedge clk);
case(index)
0: begin round16_in_value=128'h00000000000000000000000000000000; end
1: begin round16_in_value=128'h80000000000000000000000000000000; end
2: begin round16_in_value=128'h7fffffffffffffffffffffffffffffff; end
3: begin round16_in_value=128'hffffffffffffffffffff800000007fff; end
4: begin round16_in_value=128'hffffffffffffffffffff800000008000; end
5: begin round16_in_value=128'hffffffffffffffffffff800000008001; end
6: begin round16_in_value=128'hfffffffffffffffffffffffffffe7fff; end
7: begin round16_in_value=128'hfffffffffffffffffffffffffffe8000; end
8: begin round16_in_value=128'hfffffffffffffffffffffffffffe8001; end
9: begin round16_in_value=128'hffffffffffffffffffffffffffff7fff; end
10: begin round16_in_value=128'hffffffffffffffffffffffffffff8000; end
11: begin round16_in_value=128'hffffffffffffffffffffffffffff8001; end
12: begin round16_in_value=128'h00000000000000000000000000007fff; end
13: begin round16_in_value=128'h00000000000000000000000000008000; end
14: begin round16_in_value=128'h00000000000000000000000000008001; end
15: begin round16_in_value=128'h00000000000000000000000000017fff; end
16: begin round16_in_value=128'h00000000000000000000000000018000; end
17: begin round16_in_value=128'h00000000000000000000000000018001; end
18: begin round16_in_value=128'h000000000000000000007fffffff7fff; end
19: begin round16_in_value=128'h000000000000000000007fffffff8000; end
20: begin round16_in_value=128'h000000000000000000007fffffff8001; end
default: $fatal(1,"BAD_CASE");
endcase
round16_iv=1; @(posedge clk);
if (round16_ir !== 1'b1) $fatal(1,"ACCEPT_round16");
#1; elapsed=0;
repeat (0) begin
if (round16_ov !== 1'b0) $fatal(1,"EARLY_VALID_round16 edge=%0d",elapsed);
@(negedge clk); round16_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
if (round16_ov !== 1'b1) $fatal(1,"LATE_VALID_round16 edge=%0d",elapsed);
case(index)
0: begin if (round16_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round16_out_value case=0 actual=%h expected=%h",round16_out_value,32'h00000000); end
1: begin if (round16_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round16_out_value case=1 actual=%h expected=%h",round16_out_value,32'h80000000); end
2: begin if (round16_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round16_out_value case=2 actual=%h expected=%h",round16_out_value,32'h7fffffff); end
3: begin if (round16_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round16_out_value case=3 actual=%h expected=%h",round16_out_value,32'h80000000); end
4: begin if (round16_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round16_out_value case=4 actual=%h expected=%h",round16_out_value,32'h80000000); end
5: begin if (round16_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round16_out_value case=5 actual=%h expected=%h",round16_out_value,32'h80000001); end
6: begin if (round16_out_value !== 32'hfffffffe) $fatal(1,"NUMERICAL_round16_out_value case=6 actual=%h expected=%h",round16_out_value,32'hfffffffe); end
7: begin if (round16_out_value !== 32'hfffffffe) $fatal(1,"NUMERICAL_round16_out_value case=7 actual=%h expected=%h",round16_out_value,32'hfffffffe); end
8: begin if (round16_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round16_out_value case=8 actual=%h expected=%h",round16_out_value,32'hffffffff); end
9: begin if (round16_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round16_out_value case=9 actual=%h expected=%h",round16_out_value,32'hffffffff); end
10: begin if (round16_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round16_out_value case=10 actual=%h expected=%h",round16_out_value,32'hffffffff); end
11: begin if (round16_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round16_out_value case=11 actual=%h expected=%h",round16_out_value,32'h00000000); end
12: begin if (round16_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round16_out_value case=12 actual=%h expected=%h",round16_out_value,32'h00000000); end
13: begin if (round16_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round16_out_value case=13 actual=%h expected=%h",round16_out_value,32'h00000001); end
14: begin if (round16_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round16_out_value case=14 actual=%h expected=%h",round16_out_value,32'h00000001); end
15: begin if (round16_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round16_out_value case=15 actual=%h expected=%h",round16_out_value,32'h00000001); end
16: begin if (round16_out_value !== 32'h00000002) $fatal(1,"NUMERICAL_round16_out_value case=16 actual=%h expected=%h",round16_out_value,32'h00000002); end
17: begin if (round16_out_value !== 32'h00000002) $fatal(1,"NUMERICAL_round16_out_value case=17 actual=%h expected=%h",round16_out_value,32'h00000002); end
18: begin if (round16_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round16_out_value case=18 actual=%h expected=%h",round16_out_value,32'h7fffffff); end
19: begin if (round16_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round16_out_value case=19 actual=%h expected=%h",round16_out_value,32'h7fffffff); end
20: begin if (round16_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round16_out_value case=20 actual=%h expected=%h",round16_out_value,32'h7fffffff); end
endcase
held={1'b1,{round16_out_value}};
@(negedge clk); round16_iv=0;
repeat(3) begin @(posedge clk);
if ({round16_ov,{round16_out_value}} !== held) $fatal(1,"STALLED_round16");
#1;
if ({round16_ov,{round16_out_value}} !== held) $fatal(1,"STALLED_POST_round16");
end
@(negedge clk); round16_or=1; @(posedge clk); #1;
if (round16_ov !== 1'b0) $fatal(1,"RETIRE_round16");
@(negedge clk); round16_or=0;
comparisons=comparisons+1;
end endtask
task automatic run_round24(input integer index);
reg [32:0] held;
integer elapsed;
begin
@(negedge clk);
while (round24_ir !== 1'b1) @(negedge clk);
case(index)
0: begin round24_in_value=128'h00000000000000000000000000000000; end
1: begin round24_in_value=128'h80000000000000000000000000000000; end
2: begin round24_in_value=128'h7fffffffffffffffffffffffffffffff; end
3: begin round24_in_value=128'hffffffffffffffffff800000007fffff; end
4: begin round24_in_value=128'hffffffffffffffffff80000000800000; end
5: begin round24_in_value=128'hffffffffffffffffff80000000800001; end
6: begin round24_in_value=128'hfffffffffffffffffffffffffe7fffff; end
7: begin round24_in_value=128'hfffffffffffffffffffffffffe800000; end
8: begin round24_in_value=128'hfffffffffffffffffffffffffe800001; end
9: begin round24_in_value=128'hffffffffffffffffffffffffff7fffff; end
10: begin round24_in_value=128'hffffffffffffffffffffffffff800000; end
11: begin round24_in_value=128'hffffffffffffffffffffffffff800001; end
12: begin round24_in_value=128'h000000000000000000000000007fffff; end
13: begin round24_in_value=128'h00000000000000000000000000800000; end
14: begin round24_in_value=128'h00000000000000000000000000800001; end
15: begin round24_in_value=128'h000000000000000000000000017fffff; end
16: begin round24_in_value=128'h00000000000000000000000001800000; end
17: begin round24_in_value=128'h00000000000000000000000001800001; end
18: begin round24_in_value=128'h0000000000000000007fffffff7fffff; end
19: begin round24_in_value=128'h0000000000000000007fffffff800000; end
20: begin round24_in_value=128'h0000000000000000007fffffff800001; end
default: $fatal(1,"BAD_CASE");
endcase
round24_iv=1; @(posedge clk);
if (round24_ir !== 1'b1) $fatal(1,"ACCEPT_round24");
#1; elapsed=0;
repeat (0) begin
if (round24_ov !== 1'b0) $fatal(1,"EARLY_VALID_round24 edge=%0d",elapsed);
@(negedge clk); round24_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
if (round24_ov !== 1'b1) $fatal(1,"LATE_VALID_round24 edge=%0d",elapsed);
case(index)
0: begin if (round24_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round24_out_value case=0 actual=%h expected=%h",round24_out_value,32'h00000000); end
1: begin if (round24_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round24_out_value case=1 actual=%h expected=%h",round24_out_value,32'h80000000); end
2: begin if (round24_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round24_out_value case=2 actual=%h expected=%h",round24_out_value,32'h7fffffff); end
3: begin if (round24_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round24_out_value case=3 actual=%h expected=%h",round24_out_value,32'h80000000); end
4: begin if (round24_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round24_out_value case=4 actual=%h expected=%h",round24_out_value,32'h80000000); end
5: begin if (round24_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round24_out_value case=5 actual=%h expected=%h",round24_out_value,32'h80000001); end
6: begin if (round24_out_value !== 32'hfffffffe) $fatal(1,"NUMERICAL_round24_out_value case=6 actual=%h expected=%h",round24_out_value,32'hfffffffe); end
7: begin if (round24_out_value !== 32'hfffffffe) $fatal(1,"NUMERICAL_round24_out_value case=7 actual=%h expected=%h",round24_out_value,32'hfffffffe); end
8: begin if (round24_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round24_out_value case=8 actual=%h expected=%h",round24_out_value,32'hffffffff); end
9: begin if (round24_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round24_out_value case=9 actual=%h expected=%h",round24_out_value,32'hffffffff); end
10: begin if (round24_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round24_out_value case=10 actual=%h expected=%h",round24_out_value,32'hffffffff); end
11: begin if (round24_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round24_out_value case=11 actual=%h expected=%h",round24_out_value,32'h00000000); end
12: begin if (round24_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round24_out_value case=12 actual=%h expected=%h",round24_out_value,32'h00000000); end
13: begin if (round24_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round24_out_value case=13 actual=%h expected=%h",round24_out_value,32'h00000001); end
14: begin if (round24_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round24_out_value case=14 actual=%h expected=%h",round24_out_value,32'h00000001); end
15: begin if (round24_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round24_out_value case=15 actual=%h expected=%h",round24_out_value,32'h00000001); end
16: begin if (round24_out_value !== 32'h00000002) $fatal(1,"NUMERICAL_round24_out_value case=16 actual=%h expected=%h",round24_out_value,32'h00000002); end
17: begin if (round24_out_value !== 32'h00000002) $fatal(1,"NUMERICAL_round24_out_value case=17 actual=%h expected=%h",round24_out_value,32'h00000002); end
18: begin if (round24_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round24_out_value case=18 actual=%h expected=%h",round24_out_value,32'h7fffffff); end
19: begin if (round24_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round24_out_value case=19 actual=%h expected=%h",round24_out_value,32'h7fffffff); end
20: begin if (round24_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round24_out_value case=20 actual=%h expected=%h",round24_out_value,32'h7fffffff); end
endcase
held={1'b1,{round24_out_value}};
@(negedge clk); round24_iv=0;
repeat(3) begin @(posedge clk);
if ({round24_ov,{round24_out_value}} !== held) $fatal(1,"STALLED_round24");
#1;
if ({round24_ov,{round24_out_value}} !== held) $fatal(1,"STALLED_POST_round24");
end
@(negedge clk); round24_or=1; @(posedge clk); #1;
if (round24_ov !== 1'b0) $fatal(1,"RETIRE_round24");
@(negedge clk); round24_or=0;
comparisons=comparisons+1;
end endtask
task automatic run_round32(input integer index);
reg [32:0] held;
integer elapsed;
begin
@(negedge clk);
while (round32_ir !== 1'b1) @(negedge clk);
case(index)
0: begin round32_in_value=128'h00000000000000000000000000000000; end
1: begin round32_in_value=128'h80000000000000000000000000000000; end
2: begin round32_in_value=128'h7fffffffffffffffffffffffffffffff; end
3: begin round32_in_value=128'hffffffffffffffff800000007fffffff; end
4: begin round32_in_value=128'hffffffffffffffff8000000080000000; end
5: begin round32_in_value=128'hffffffffffffffff8000000080000001; end
6: begin round32_in_value=128'hfffffffffffffffffffffffe7fffffff; end
7: begin round32_in_value=128'hfffffffffffffffffffffffe80000000; end
8: begin round32_in_value=128'hfffffffffffffffffffffffe80000001; end
9: begin round32_in_value=128'hffffffffffffffffffffffff7fffffff; end
10: begin round32_in_value=128'hffffffffffffffffffffffff80000000; end
11: begin round32_in_value=128'hffffffffffffffffffffffff80000001; end
12: begin round32_in_value=128'h0000000000000000000000007fffffff; end
13: begin round32_in_value=128'h00000000000000000000000080000000; end
14: begin round32_in_value=128'h00000000000000000000000080000001; end
15: begin round32_in_value=128'h0000000000000000000000017fffffff; end
16: begin round32_in_value=128'h00000000000000000000000180000000; end
17: begin round32_in_value=128'h00000000000000000000000180000001; end
18: begin round32_in_value=128'h00000000000000007fffffff7fffffff; end
19: begin round32_in_value=128'h00000000000000007fffffff80000000; end
20: begin round32_in_value=128'h00000000000000007fffffff80000001; end
default: $fatal(1,"BAD_CASE");
endcase
round32_iv=1; @(posedge clk);
if (round32_ir !== 1'b1) $fatal(1,"ACCEPT_round32");
#1; elapsed=0;
repeat (0) begin
if (round32_ov !== 1'b0) $fatal(1,"EARLY_VALID_round32 edge=%0d",elapsed);
@(negedge clk); round32_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
if (round32_ov !== 1'b1) $fatal(1,"LATE_VALID_round32 edge=%0d",elapsed);
case(index)
0: begin if (round32_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round32_out_value case=0 actual=%h expected=%h",round32_out_value,32'h00000000); end
1: begin if (round32_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round32_out_value case=1 actual=%h expected=%h",round32_out_value,32'h80000000); end
2: begin if (round32_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round32_out_value case=2 actual=%h expected=%h",round32_out_value,32'h7fffffff); end
3: begin if (round32_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round32_out_value case=3 actual=%h expected=%h",round32_out_value,32'h80000000); end
4: begin if (round32_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round32_out_value case=4 actual=%h expected=%h",round32_out_value,32'h80000000); end
5: begin if (round32_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round32_out_value case=5 actual=%h expected=%h",round32_out_value,32'h80000001); end
6: begin if (round32_out_value !== 32'hfffffffe) $fatal(1,"NUMERICAL_round32_out_value case=6 actual=%h expected=%h",round32_out_value,32'hfffffffe); end
7: begin if (round32_out_value !== 32'hfffffffe) $fatal(1,"NUMERICAL_round32_out_value case=7 actual=%h expected=%h",round32_out_value,32'hfffffffe); end
8: begin if (round32_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round32_out_value case=8 actual=%h expected=%h",round32_out_value,32'hffffffff); end
9: begin if (round32_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round32_out_value case=9 actual=%h expected=%h",round32_out_value,32'hffffffff); end
10: begin if (round32_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round32_out_value case=10 actual=%h expected=%h",round32_out_value,32'hffffffff); end
11: begin if (round32_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round32_out_value case=11 actual=%h expected=%h",round32_out_value,32'h00000000); end
12: begin if (round32_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round32_out_value case=12 actual=%h expected=%h",round32_out_value,32'h00000000); end
13: begin if (round32_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round32_out_value case=13 actual=%h expected=%h",round32_out_value,32'h00000001); end
14: begin if (round32_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round32_out_value case=14 actual=%h expected=%h",round32_out_value,32'h00000001); end
15: begin if (round32_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round32_out_value case=15 actual=%h expected=%h",round32_out_value,32'h00000001); end
16: begin if (round32_out_value !== 32'h00000002) $fatal(1,"NUMERICAL_round32_out_value case=16 actual=%h expected=%h",round32_out_value,32'h00000002); end
17: begin if (round32_out_value !== 32'h00000002) $fatal(1,"NUMERICAL_round32_out_value case=17 actual=%h expected=%h",round32_out_value,32'h00000002); end
18: begin if (round32_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round32_out_value case=18 actual=%h expected=%h",round32_out_value,32'h7fffffff); end
19: begin if (round32_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round32_out_value case=19 actual=%h expected=%h",round32_out_value,32'h7fffffff); end
20: begin if (round32_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round32_out_value case=20 actual=%h expected=%h",round32_out_value,32'h7fffffff); end
endcase
held={1'b1,{round32_out_value}};
@(negedge clk); round32_iv=0;
repeat(3) begin @(posedge clk);
if ({round32_ov,{round32_out_value}} !== held) $fatal(1,"STALLED_round32");
#1;
if ({round32_ov,{round32_out_value}} !== held) $fatal(1,"STALLED_POST_round32");
end
@(negedge clk); round32_or=1; @(posedge clk); #1;
if (round32_ov !== 1'b0) $fatal(1,"RETIRE_round32");
@(negedge clk); round32_or=0;
comparisons=comparisons+1;
end endtask
task automatic run_round48(input integer index);
reg [32:0] held;
integer elapsed;
begin
@(negedge clk);
while (round48_ir !== 1'b1) @(negedge clk);
case(index)
0: begin round48_in_value=128'h00000000000000000000000000000000; end
1: begin round48_in_value=128'h80000000000000000000000000000000; end
2: begin round48_in_value=128'h7fffffffffffffffffffffffffffffff; end
3: begin round48_in_value=128'hffffffffffff800000007fffffffffff; end
4: begin round48_in_value=128'hffffffffffff80000000800000000000; end
5: begin round48_in_value=128'hffffffffffff80000000800000000001; end
6: begin round48_in_value=128'hfffffffffffffffffffe7fffffffffff; end
7: begin round48_in_value=128'hfffffffffffffffffffe800000000000; end
8: begin round48_in_value=128'hfffffffffffffffffffe800000000001; end
9: begin round48_in_value=128'hffffffffffffffffffff7fffffffffff; end
10: begin round48_in_value=128'hffffffffffffffffffff800000000000; end
11: begin round48_in_value=128'hffffffffffffffffffff800000000001; end
12: begin round48_in_value=128'h000000000000000000007fffffffffff; end
13: begin round48_in_value=128'h00000000000000000000800000000000; end
14: begin round48_in_value=128'h00000000000000000000800000000001; end
15: begin round48_in_value=128'h000000000000000000017fffffffffff; end
16: begin round48_in_value=128'h00000000000000000001800000000000; end
17: begin round48_in_value=128'h00000000000000000001800000000001; end
18: begin round48_in_value=128'h0000000000007fffffff7fffffffffff; end
19: begin round48_in_value=128'h0000000000007fffffff800000000000; end
20: begin round48_in_value=128'h0000000000007fffffff800000000001; end
21: begin round48_in_value=128'h000000000000000000fffffb00000000; end
22: begin round48_in_value=128'h00000000000000000000000000000000; end
23: begin round48_in_value=128'h00000000000000000000000000000000; end
24: begin round48_in_value=128'h00000000000000000000000000000000; end
25: begin round48_in_value=128'h00000000000000000000000000000000; end
26: begin round48_in_value=128'h00000000000000000000000000000000; end
27: begin round48_in_value=128'h00000000000000000000000000000000; end
28: begin round48_in_value=128'h00000000000000000000000000000000; end
29: begin round48_in_value=128'h00000000000000000000000000000000; end
30: begin round48_in_value=128'h00000000000000000000000000000000; end
31: begin round48_in_value=128'h00000000000000000000000000000000; end
32: begin round48_in_value=128'h00000000000000000000000000000000; end
33: begin round48_in_value=128'h00000000000000000000000000000000; end
34: begin round48_in_value=128'h00000000000000000000000000000000; end
35: begin round48_in_value=128'h00000000000000000000000000000000; end
36: begin round48_in_value=128'h00000000000000000000000000000000; end
37: begin round48_in_value=128'h00000000000000000000000000000000; end
38: begin round48_in_value=128'h00000000000000000000000000000000; end
39: begin round48_in_value=128'h00000000000000000000000000000000; end
40: begin round48_in_value=128'h00000000000000000000000000000000; end
41: begin round48_in_value=128'h00000000000000000000000000000000; end
42: begin round48_in_value=128'h00000000000000000000000000000000; end
43: begin round48_in_value=128'h00000000000000000000000000000000; end
44: begin round48_in_value=128'h00000000000000000000000000000000; end
45: begin round48_in_value=128'h00000000000000000000000000000000; end
46: begin round48_in_value=128'h00000000000000000000000000000000; end
47: begin round48_in_value=128'h00000000000000000000000000000000; end
48: begin round48_in_value=128'h00000000000000000000000000000000; end
49: begin round48_in_value=128'h00000000000000000000000000000000; end
50: begin round48_in_value=128'h00000000000000000000000000000000; end
51: begin round48_in_value=128'h00000000000000000000000000000000; end
52: begin round48_in_value=128'h00000000000000000000000000000000; end
53: begin round48_in_value=128'h00000000000000000000000000000000; end
54: begin round48_in_value=128'h00000000000000000000000000000000; end
55: begin round48_in_value=128'h00000000000000000000000000000000; end
56: begin round48_in_value=128'h00000000000000000000000000000000; end
57: begin round48_in_value=128'h00000000000000000000000000000000; end
58: begin round48_in_value=128'h00000000000000000000000000000000; end
59: begin round48_in_value=128'h00000000000000000000000000000000; end
60: begin round48_in_value=128'h00000000000000000000000000000000; end
61: begin round48_in_value=128'h00000000000000000000000000000000; end
62: begin round48_in_value=128'h00000000000000000000000000000000; end
63: begin round48_in_value=128'h00000000000000000000000000000000; end
64: begin round48_in_value=128'h00000000000000000000000000000000; end
65: begin round48_in_value=128'h00000000000000000000000000000000; end
66: begin round48_in_value=128'h00000000000000000000000000000000; end
67: begin round48_in_value=128'h00000000000000000000000000000000; end
68: begin round48_in_value=128'h00000000000000000000000000000000; end
69: begin round48_in_value=128'hffffffffffff80000001000000000000; end
70: begin round48_in_value=128'hffffffffffff80000001000000000000; end
71: begin round48_in_value=128'hffffffffffff80000001000000000000; end
72: begin round48_in_value=128'hffffffffffff80000001000000000000; end
73: begin round48_in_value=128'hffffffffffff80000001000000000000; end
74: begin round48_in_value=128'hffffffffffff80000001000000000000; end
75: begin round48_in_value=128'hffffffffffff80000001000000000000; end
76: begin round48_in_value=128'hffffffffffff80000001000000000000; end
77: begin round48_in_value=128'hffffffffffff80000001000000000000; end
78: begin round48_in_value=128'hffffffffffff80000001000000000000; end
79: begin round48_in_value=128'hffffffffffff80000001000000000000; end
80: begin round48_in_value=128'hffffffffffff80000001000000000000; end
81: begin round48_in_value=128'hffffffffffff80000001000000000000; end
82: begin round48_in_value=128'hffffffffffff80000001000000000000; end
83: begin round48_in_value=128'hffffffffffff80000001000000000000; end
84: begin round48_in_value=128'hffffffffffff80000001000000000000; end
85: begin round48_in_value=128'hffffffffffff80000001000000000000; end
86: begin round48_in_value=128'hffffffffffff80000001000000000000; end
87: begin round48_in_value=128'hffffffffffff80000001000000000000; end
88: begin round48_in_value=128'hffffffffffff80000001000000000000; end
89: begin round48_in_value=128'hffffffffffff80000001000000000000; end
90: begin round48_in_value=128'hffffffffffff80000001000000000000; end
91: begin round48_in_value=128'hffffffffffff80000001000000000000; end
92: begin round48_in_value=128'hffffffffffff80000001000000000000; end
93: begin round48_in_value=128'hfffffffffffffdc98103eb03e2d04a7c; end
94: begin round48_in_value=128'hffffffffffffffc995cbbd899c620434; end
95: begin round48_in_value=128'h0000000000000064264a844db0850890; end
96: begin round48_in_value=128'h00000000000000352e69e25c836012b8; end
97: begin round48_in_value=128'h0000000000000314def8940c43ab1628; end
98: begin round48_in_value=128'hffffffffffffffa98f6769e72b6ea6c4; end
99: begin round48_in_value=128'hffffffffffffffc90c451986445476c4; end
100: begin round48_in_value=128'h00000000000000000000000000000000; end
101: begin round48_in_value=128'h000000000000030941144a5a25d3e328; end
102: begin round48_in_value=128'hfffffffffffffebe6d20429ed58c82b0; end
103: begin round48_in_value=128'h00000000000000553d6b5bbb6f8c7150; end
104: begin round48_in_value=128'h000000000000026a60da6834b5e3c998; end
105: begin round48_in_value=128'hfffffffffffffe6fdf1d761adccf0298; end
106: begin round48_in_value=128'h00000000000002235590e908bbb33140; end
107: begin round48_in_value=128'h000000000000010285b625c59bee3de0; end
108: begin round48_in_value=128'h0000000000000277711a8618d6331240; end
109: begin round48_in_value=128'hffffffffffffff44dcb7ff36a4043460; end
110: begin round48_in_value=128'hffffffffffffffddde70b5029f58b9c4; end
111: begin round48_in_value=128'h000000000000003bebba2578e5d2dc3c; end
112: begin round48_in_value=128'hffffffffffffffce1c7c8bd104dc61b8; end
113: begin round48_in_value=128'h0000000000000012b27e29a5ed1fe1e0; end
114: begin round48_in_value=128'hffffffffffffff4eb62ad5acfd629b30; end
115: begin round48_in_value=128'h000000000000022a1375c822ba784b94; end
116: begin round48_in_value=128'hffffffffffffffc6d3e3dc5c04047d00; end
117: begin round48_in_value=128'h0000000000005c747c04c10f5ab7a688; end
118: begin round48_in_value=128'hffffffffffffb595af30041a74135376; end
119: begin round48_in_value=128'h00000000000005ec065de4daef9b5f9c; end
120: begin round48_in_value=128'hffffffffffffe8146e0795c479c06b52; end
121: begin round48_in_value=128'hffffffffffffc86e75c6a442fd314ca0; end
122: begin round48_in_value=128'h00000000000000a6aec97ec37cf1f26a; end
123: begin round48_in_value=128'h0000000000001188b7395536535d26d0; end
124: begin round48_in_value=128'hfffffffffffffdabd927008a36a2234e; end
125: begin round48_in_value=128'hfffffffffffffbf3e26d7cab177de3bc; end
126: begin round48_in_value=128'hffffffffffffffc5708fcb0d811e9098; end
127: begin round48_in_value=128'hfffffffffffff300245a5e8e43d35238; end
128: begin round48_in_value=128'h00000000000032e571f42bb117f28ed8; end
129: begin round48_in_value=128'h00000000000000d40ca6a93f16040df8; end
130: begin round48_in_value=128'h00000000000031fa82fb6bc1249b83a8; end
131: begin round48_in_value=128'hfffffffffffffc1347b38523635a450e; end
132: begin round48_in_value=128'hffffffffffffcabd58f652f4db5a8d78; end
133: begin round48_in_value=128'hffffffffffffe2787eafcbbb4b9360da; end
134: begin round48_in_value=128'hffffffffffffdc1c6f519aef0685b3c8; end
135: begin round48_in_value=128'h00000000000006a0d6d0c7ba080cccc0; end
136: begin round48_in_value=128'h00000000000030cb69736dab74215622; end
137: begin round48_in_value=128'hffffffffffffe71ee3670097d747f33e; end
138: begin round48_in_value=128'hfffffffffffff83ebcbb7f092088ade4; end
139: begin round48_in_value=128'hffffffffffffece80feec58e0c289104; end
140: begin round48_in_value=128'h00000000000012688114fbc20619c234; end
141: begin round48_in_value=128'h000000000000012f4940024f367f65de; end
142: begin round48_in_value=128'h0000000000000017d12ce496f85531b0; end
143: begin round48_in_value=128'hffffffffffffffc5e38919b4ebd9f092; end
144: begin round48_in_value=128'hfffffffffffffdebca735b9d1972bd96; end
145: begin round48_in_value=128'hffffffffffffffff8e035ecf9f3e3a9c; end
146: begin round48_in_value=128'hffffffffffffff8181f27ca758ffa260; end
147: begin round48_in_value=128'hfffffffffffffe5a889bfc8bad44b9ce; end
148: begin round48_in_value=128'hffffffffffffffcce73bbd225bedb6cc; end
149: begin round48_in_value=128'h000000000000021fcfa3cbd48de86fd0; end
150: begin round48_in_value=128'h0000000000000071601042cd3164e974; end
151: begin round48_in_value=128'hfffffffffffffe026885af56b028d482; end
152: begin round48_in_value=128'h00000000000000883e3de413f7a73498; end
153: begin round48_in_value=128'hffffffffffffff78fff51bf9b2f56920; end
154: begin round48_in_value=128'hffffffffffffff5489851b4a8d6f4f00; end
155: begin round48_in_value=128'h0000000000000209ac4e713ee71eef14; end
156: begin round48_in_value=128'hfffffffffffffe2205c767df40eafc00; end
157: begin round48_in_value=128'h00000000000000a5ab77fe1e0de45820; end
158: begin round48_in_value=128'hffffffffffffff26585a6d8ce899e412; end
159: begin round48_in_value=128'hffffffffffffffdf75b0cf5663b8df6c; end
160: begin round48_in_value=128'hffffffffffffff150371a635866f2f68; end
161: begin round48_in_value=128'hffffffffffffffd0d3bdd4864fc5a312; end
162: begin round48_in_value=128'hffffffffffffff0347b606b8fd5ba830; end
163: begin round48_in_value=128'hfffffffffffffe060a2a9b4c914cdb26; end
164: begin round48_in_value=128'h000000000000004aac7ce4d4e7d29d68; end
default: $fatal(1,"BAD_CASE");
endcase
round48_iv=1; @(posedge clk);
if (round48_ir !== 1'b1) $fatal(1,"ACCEPT_round48");
#1; elapsed=0;
repeat (0) begin
if (round48_ov !== 1'b0) $fatal(1,"EARLY_VALID_round48 edge=%0d",elapsed);
@(negedge clk); round48_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
if (round48_ov !== 1'b1) $fatal(1,"LATE_VALID_round48 edge=%0d",elapsed);
case(index)
0: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=0 actual=%h expected=%h",round48_out_value,32'h00000000); end
1: begin if (round48_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round48_out_value case=1 actual=%h expected=%h",round48_out_value,32'h80000000); end
2: begin if (round48_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round48_out_value case=2 actual=%h expected=%h",round48_out_value,32'h7fffffff); end
3: begin if (round48_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round48_out_value case=3 actual=%h expected=%h",round48_out_value,32'h80000000); end
4: begin if (round48_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round48_out_value case=4 actual=%h expected=%h",round48_out_value,32'h80000000); end
5: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=5 actual=%h expected=%h",round48_out_value,32'h80000001); end
6: begin if (round48_out_value !== 32'hfffffffe) $fatal(1,"NUMERICAL_round48_out_value case=6 actual=%h expected=%h",round48_out_value,32'hfffffffe); end
7: begin if (round48_out_value !== 32'hfffffffe) $fatal(1,"NUMERICAL_round48_out_value case=7 actual=%h expected=%h",round48_out_value,32'hfffffffe); end
8: begin if (round48_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round48_out_value case=8 actual=%h expected=%h",round48_out_value,32'hffffffff); end
9: begin if (round48_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round48_out_value case=9 actual=%h expected=%h",round48_out_value,32'hffffffff); end
10: begin if (round48_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round48_out_value case=10 actual=%h expected=%h",round48_out_value,32'hffffffff); end
11: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=11 actual=%h expected=%h",round48_out_value,32'h00000000); end
12: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=12 actual=%h expected=%h",round48_out_value,32'h00000000); end
13: begin if (round48_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round48_out_value case=13 actual=%h expected=%h",round48_out_value,32'h00000001); end
14: begin if (round48_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round48_out_value case=14 actual=%h expected=%h",round48_out_value,32'h00000001); end
15: begin if (round48_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round48_out_value case=15 actual=%h expected=%h",round48_out_value,32'h00000001); end
16: begin if (round48_out_value !== 32'h00000002) $fatal(1,"NUMERICAL_round48_out_value case=16 actual=%h expected=%h",round48_out_value,32'h00000002); end
17: begin if (round48_out_value !== 32'h00000002) $fatal(1,"NUMERICAL_round48_out_value case=17 actual=%h expected=%h",round48_out_value,32'h00000002); end
18: begin if (round48_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round48_out_value case=18 actual=%h expected=%h",round48_out_value,32'h7fffffff); end
19: begin if (round48_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round48_out_value case=19 actual=%h expected=%h",round48_out_value,32'h7fffffff); end
20: begin if (round48_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round48_out_value case=20 actual=%h expected=%h",round48_out_value,32'h7fffffff); end
21: begin if (round48_out_value !== 32'h00000100) $fatal(1,"NUMERICAL_round48_out_value case=21 actual=%h expected=%h",round48_out_value,32'h00000100); end
22: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=22 actual=%h expected=%h",round48_out_value,32'h00000000); end
23: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=23 actual=%h expected=%h",round48_out_value,32'h00000000); end
24: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=24 actual=%h expected=%h",round48_out_value,32'h00000000); end
25: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=25 actual=%h expected=%h",round48_out_value,32'h00000000); end
26: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=26 actual=%h expected=%h",round48_out_value,32'h00000000); end
27: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=27 actual=%h expected=%h",round48_out_value,32'h00000000); end
28: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=28 actual=%h expected=%h",round48_out_value,32'h00000000); end
29: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=29 actual=%h expected=%h",round48_out_value,32'h00000000); end
30: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=30 actual=%h expected=%h",round48_out_value,32'h00000000); end
31: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=31 actual=%h expected=%h",round48_out_value,32'h00000000); end
32: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=32 actual=%h expected=%h",round48_out_value,32'h00000000); end
33: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=33 actual=%h expected=%h",round48_out_value,32'h00000000); end
34: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=34 actual=%h expected=%h",round48_out_value,32'h00000000); end
35: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=35 actual=%h expected=%h",round48_out_value,32'h00000000); end
36: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=36 actual=%h expected=%h",round48_out_value,32'h00000000); end
37: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=37 actual=%h expected=%h",round48_out_value,32'h00000000); end
38: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=38 actual=%h expected=%h",round48_out_value,32'h00000000); end
39: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=39 actual=%h expected=%h",round48_out_value,32'h00000000); end
40: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=40 actual=%h expected=%h",round48_out_value,32'h00000000); end
41: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=41 actual=%h expected=%h",round48_out_value,32'h00000000); end
42: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=42 actual=%h expected=%h",round48_out_value,32'h00000000); end
43: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=43 actual=%h expected=%h",round48_out_value,32'h00000000); end
44: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=44 actual=%h expected=%h",round48_out_value,32'h00000000); end
45: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=45 actual=%h expected=%h",round48_out_value,32'h00000000); end
46: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=46 actual=%h expected=%h",round48_out_value,32'h00000000); end
47: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=47 actual=%h expected=%h",round48_out_value,32'h00000000); end
48: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=48 actual=%h expected=%h",round48_out_value,32'h00000000); end
49: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=49 actual=%h expected=%h",round48_out_value,32'h00000000); end
50: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=50 actual=%h expected=%h",round48_out_value,32'h00000000); end
51: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=51 actual=%h expected=%h",round48_out_value,32'h00000000); end
52: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=52 actual=%h expected=%h",round48_out_value,32'h00000000); end
53: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=53 actual=%h expected=%h",round48_out_value,32'h00000000); end
54: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=54 actual=%h expected=%h",round48_out_value,32'h00000000); end
55: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=55 actual=%h expected=%h",round48_out_value,32'h00000000); end
56: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=56 actual=%h expected=%h",round48_out_value,32'h00000000); end
57: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=57 actual=%h expected=%h",round48_out_value,32'h00000000); end
58: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=58 actual=%h expected=%h",round48_out_value,32'h00000000); end
59: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=59 actual=%h expected=%h",round48_out_value,32'h00000000); end
60: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=60 actual=%h expected=%h",round48_out_value,32'h00000000); end
61: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=61 actual=%h expected=%h",round48_out_value,32'h00000000); end
62: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=62 actual=%h expected=%h",round48_out_value,32'h00000000); end
63: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=63 actual=%h expected=%h",round48_out_value,32'h00000000); end
64: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=64 actual=%h expected=%h",round48_out_value,32'h00000000); end
65: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=65 actual=%h expected=%h",round48_out_value,32'h00000000); end
66: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=66 actual=%h expected=%h",round48_out_value,32'h00000000); end
67: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=67 actual=%h expected=%h",round48_out_value,32'h00000000); end
68: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=68 actual=%h expected=%h",round48_out_value,32'h00000000); end
69: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=69 actual=%h expected=%h",round48_out_value,32'h80000001); end
70: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=70 actual=%h expected=%h",round48_out_value,32'h80000001); end
71: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=71 actual=%h expected=%h",round48_out_value,32'h80000001); end
72: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=72 actual=%h expected=%h",round48_out_value,32'h80000001); end
73: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=73 actual=%h expected=%h",round48_out_value,32'h80000001); end
74: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=74 actual=%h expected=%h",round48_out_value,32'h80000001); end
75: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=75 actual=%h expected=%h",round48_out_value,32'h80000001); end
76: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=76 actual=%h expected=%h",round48_out_value,32'h80000001); end
77: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=77 actual=%h expected=%h",round48_out_value,32'h80000001); end
78: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=78 actual=%h expected=%h",round48_out_value,32'h80000001); end
79: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=79 actual=%h expected=%h",round48_out_value,32'h80000001); end
80: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=80 actual=%h expected=%h",round48_out_value,32'h80000001); end
81: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=81 actual=%h expected=%h",round48_out_value,32'h80000001); end
82: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=82 actual=%h expected=%h",round48_out_value,32'h80000001); end
83: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=83 actual=%h expected=%h",round48_out_value,32'h80000001); end
84: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=84 actual=%h expected=%h",round48_out_value,32'h80000001); end
85: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=85 actual=%h expected=%h",round48_out_value,32'h80000001); end
86: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=86 actual=%h expected=%h",round48_out_value,32'h80000001); end
87: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=87 actual=%h expected=%h",round48_out_value,32'h80000001); end
88: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=88 actual=%h expected=%h",round48_out_value,32'h80000001); end
89: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=89 actual=%h expected=%h",round48_out_value,32'h80000001); end
90: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=90 actual=%h expected=%h",round48_out_value,32'h80000001); end
91: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=91 actual=%h expected=%h",round48_out_value,32'h80000001); end
92: begin if (round48_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round48_out_value case=92 actual=%h expected=%h",round48_out_value,32'h80000001); end
93: begin if (round48_out_value !== 32'hfdc98104) $fatal(1,"NUMERICAL_round48_out_value case=93 actual=%h expected=%h",round48_out_value,32'hfdc98104); end
94: begin if (round48_out_value !== 32'hffc995cc) $fatal(1,"NUMERICAL_round48_out_value case=94 actual=%h expected=%h",round48_out_value,32'hffc995cc); end
95: begin if (round48_out_value !== 32'h0064264b) $fatal(1,"NUMERICAL_round48_out_value case=95 actual=%h expected=%h",round48_out_value,32'h0064264b); end
96: begin if (round48_out_value !== 32'h00352e6a) $fatal(1,"NUMERICAL_round48_out_value case=96 actual=%h expected=%h",round48_out_value,32'h00352e6a); end
97: begin if (round48_out_value !== 32'h0314def9) $fatal(1,"NUMERICAL_round48_out_value case=97 actual=%h expected=%h",round48_out_value,32'h0314def9); end
98: begin if (round48_out_value !== 32'hffa98f67) $fatal(1,"NUMERICAL_round48_out_value case=98 actual=%h expected=%h",round48_out_value,32'hffa98f67); end
99: begin if (round48_out_value !== 32'hffc90c45) $fatal(1,"NUMERICAL_round48_out_value case=99 actual=%h expected=%h",round48_out_value,32'hffc90c45); end
100: begin if (round48_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round48_out_value case=100 actual=%h expected=%h",round48_out_value,32'h00000000); end
101: begin if (round48_out_value !== 32'h03094114) $fatal(1,"NUMERICAL_round48_out_value case=101 actual=%h expected=%h",round48_out_value,32'h03094114); end
102: begin if (round48_out_value !== 32'hfebe6d20) $fatal(1,"NUMERICAL_round48_out_value case=102 actual=%h expected=%h",round48_out_value,32'hfebe6d20); end
103: begin if (round48_out_value !== 32'h00553d6b) $fatal(1,"NUMERICAL_round48_out_value case=103 actual=%h expected=%h",round48_out_value,32'h00553d6b); end
104: begin if (round48_out_value !== 32'h026a60da) $fatal(1,"NUMERICAL_round48_out_value case=104 actual=%h expected=%h",round48_out_value,32'h026a60da); end
105: begin if (round48_out_value !== 32'hfe6fdf1d) $fatal(1,"NUMERICAL_round48_out_value case=105 actual=%h expected=%h",round48_out_value,32'hfe6fdf1d); end
106: begin if (round48_out_value !== 32'h02235591) $fatal(1,"NUMERICAL_round48_out_value case=106 actual=%h expected=%h",round48_out_value,32'h02235591); end
107: begin if (round48_out_value !== 32'h010285b6) $fatal(1,"NUMERICAL_round48_out_value case=107 actual=%h expected=%h",round48_out_value,32'h010285b6); end
108: begin if (round48_out_value !== 32'h0277711b) $fatal(1,"NUMERICAL_round48_out_value case=108 actual=%h expected=%h",round48_out_value,32'h0277711b); end
109: begin if (round48_out_value !== 32'hff44dcb8) $fatal(1,"NUMERICAL_round48_out_value case=109 actual=%h expected=%h",round48_out_value,32'hff44dcb8); end
110: begin if (round48_out_value !== 32'hffddde71) $fatal(1,"NUMERICAL_round48_out_value case=110 actual=%h expected=%h",round48_out_value,32'hffddde71); end
111: begin if (round48_out_value !== 32'h003bebba) $fatal(1,"NUMERICAL_round48_out_value case=111 actual=%h expected=%h",round48_out_value,32'h003bebba); end
112: begin if (round48_out_value !== 32'hffce1c7d) $fatal(1,"NUMERICAL_round48_out_value case=112 actual=%h expected=%h",round48_out_value,32'hffce1c7d); end
113: begin if (round48_out_value !== 32'h0012b27e) $fatal(1,"NUMERICAL_round48_out_value case=113 actual=%h expected=%h",round48_out_value,32'h0012b27e); end
114: begin if (round48_out_value !== 32'hff4eb62b) $fatal(1,"NUMERICAL_round48_out_value case=114 actual=%h expected=%h",round48_out_value,32'hff4eb62b); end
115: begin if (round48_out_value !== 32'h022a1376) $fatal(1,"NUMERICAL_round48_out_value case=115 actual=%h expected=%h",round48_out_value,32'h022a1376); end
116: begin if (round48_out_value !== 32'hffc6d3e4) $fatal(1,"NUMERICAL_round48_out_value case=116 actual=%h expected=%h",round48_out_value,32'hffc6d3e4); end
117: begin if (round48_out_value !== 32'h5c747c05) $fatal(1,"NUMERICAL_round48_out_value case=117 actual=%h expected=%h",round48_out_value,32'h5c747c05); end
118: begin if (round48_out_value !== 32'hb595af30) $fatal(1,"NUMERICAL_round48_out_value case=118 actual=%h expected=%h",round48_out_value,32'hb595af30); end
119: begin if (round48_out_value !== 32'h05ec065e) $fatal(1,"NUMERICAL_round48_out_value case=119 actual=%h expected=%h",round48_out_value,32'h05ec065e); end
120: begin if (round48_out_value !== 32'he8146e08) $fatal(1,"NUMERICAL_round48_out_value case=120 actual=%h expected=%h",round48_out_value,32'he8146e08); end
121: begin if (round48_out_value !== 32'hc86e75c7) $fatal(1,"NUMERICAL_round48_out_value case=121 actual=%h expected=%h",round48_out_value,32'hc86e75c7); end
122: begin if (round48_out_value !== 32'h00a6aec9) $fatal(1,"NUMERICAL_round48_out_value case=122 actual=%h expected=%h",round48_out_value,32'h00a6aec9); end
123: begin if (round48_out_value !== 32'h1188b739) $fatal(1,"NUMERICAL_round48_out_value case=123 actual=%h expected=%h",round48_out_value,32'h1188b739); end
124: begin if (round48_out_value !== 32'hfdabd927) $fatal(1,"NUMERICAL_round48_out_value case=124 actual=%h expected=%h",round48_out_value,32'hfdabd927); end
125: begin if (round48_out_value !== 32'hfbf3e26d) $fatal(1,"NUMERICAL_round48_out_value case=125 actual=%h expected=%h",round48_out_value,32'hfbf3e26d); end
126: begin if (round48_out_value !== 32'hffc57090) $fatal(1,"NUMERICAL_round48_out_value case=126 actual=%h expected=%h",round48_out_value,32'hffc57090); end
127: begin if (round48_out_value !== 32'hf300245a) $fatal(1,"NUMERICAL_round48_out_value case=127 actual=%h expected=%h",round48_out_value,32'hf300245a); end
128: begin if (round48_out_value !== 32'h32e571f4) $fatal(1,"NUMERICAL_round48_out_value case=128 actual=%h expected=%h",round48_out_value,32'h32e571f4); end
129: begin if (round48_out_value !== 32'h00d40ca7) $fatal(1,"NUMERICAL_round48_out_value case=129 actual=%h expected=%h",round48_out_value,32'h00d40ca7); end
130: begin if (round48_out_value !== 32'h31fa82fb) $fatal(1,"NUMERICAL_round48_out_value case=130 actual=%h expected=%h",round48_out_value,32'h31fa82fb); end
131: begin if (round48_out_value !== 32'hfc1347b4) $fatal(1,"NUMERICAL_round48_out_value case=131 actual=%h expected=%h",round48_out_value,32'hfc1347b4); end
132: begin if (round48_out_value !== 32'hcabd58f6) $fatal(1,"NUMERICAL_round48_out_value case=132 actual=%h expected=%h",round48_out_value,32'hcabd58f6); end
133: begin if (round48_out_value !== 32'he2787eb0) $fatal(1,"NUMERICAL_round48_out_value case=133 actual=%h expected=%h",round48_out_value,32'he2787eb0); end
134: begin if (round48_out_value !== 32'hdc1c6f52) $fatal(1,"NUMERICAL_round48_out_value case=134 actual=%h expected=%h",round48_out_value,32'hdc1c6f52); end
135: begin if (round48_out_value !== 32'h06a0d6d1) $fatal(1,"NUMERICAL_round48_out_value case=135 actual=%h expected=%h",round48_out_value,32'h06a0d6d1); end
136: begin if (round48_out_value !== 32'h30cb6973) $fatal(1,"NUMERICAL_round48_out_value case=136 actual=%h expected=%h",round48_out_value,32'h30cb6973); end
137: begin if (round48_out_value !== 32'he71ee367) $fatal(1,"NUMERICAL_round48_out_value case=137 actual=%h expected=%h",round48_out_value,32'he71ee367); end
138: begin if (round48_out_value !== 32'hf83ebcbb) $fatal(1,"NUMERICAL_round48_out_value case=138 actual=%h expected=%h",round48_out_value,32'hf83ebcbb); end
139: begin if (round48_out_value !== 32'hece80fef) $fatal(1,"NUMERICAL_round48_out_value case=139 actual=%h expected=%h",round48_out_value,32'hece80fef); end
140: begin if (round48_out_value !== 32'h12688115) $fatal(1,"NUMERICAL_round48_out_value case=140 actual=%h expected=%h",round48_out_value,32'h12688115); end
141: begin if (round48_out_value !== 32'h012f4940) $fatal(1,"NUMERICAL_round48_out_value case=141 actual=%h expected=%h",round48_out_value,32'h012f4940); end
142: begin if (round48_out_value !== 32'h0017d12d) $fatal(1,"NUMERICAL_round48_out_value case=142 actual=%h expected=%h",round48_out_value,32'h0017d12d); end
143: begin if (round48_out_value !== 32'hffc5e389) $fatal(1,"NUMERICAL_round48_out_value case=143 actual=%h expected=%h",round48_out_value,32'hffc5e389); end
144: begin if (round48_out_value !== 32'hfdebca73) $fatal(1,"NUMERICAL_round48_out_value case=144 actual=%h expected=%h",round48_out_value,32'hfdebca73); end
145: begin if (round48_out_value !== 32'hffff8e03) $fatal(1,"NUMERICAL_round48_out_value case=145 actual=%h expected=%h",round48_out_value,32'hffff8e03); end
146: begin if (round48_out_value !== 32'hff8181f2) $fatal(1,"NUMERICAL_round48_out_value case=146 actual=%h expected=%h",round48_out_value,32'hff8181f2); end
147: begin if (round48_out_value !== 32'hfe5a889c) $fatal(1,"NUMERICAL_round48_out_value case=147 actual=%h expected=%h",round48_out_value,32'hfe5a889c); end
148: begin if (round48_out_value !== 32'hffcce73c) $fatal(1,"NUMERICAL_round48_out_value case=148 actual=%h expected=%h",round48_out_value,32'hffcce73c); end
149: begin if (round48_out_value !== 32'h021fcfa4) $fatal(1,"NUMERICAL_round48_out_value case=149 actual=%h expected=%h",round48_out_value,32'h021fcfa4); end
150: begin if (round48_out_value !== 32'h00716010) $fatal(1,"NUMERICAL_round48_out_value case=150 actual=%h expected=%h",round48_out_value,32'h00716010); end
151: begin if (round48_out_value !== 32'hfe026886) $fatal(1,"NUMERICAL_round48_out_value case=151 actual=%h expected=%h",round48_out_value,32'hfe026886); end
152: begin if (round48_out_value !== 32'h00883e3e) $fatal(1,"NUMERICAL_round48_out_value case=152 actual=%h expected=%h",round48_out_value,32'h00883e3e); end
153: begin if (round48_out_value !== 32'hff78fff5) $fatal(1,"NUMERICAL_round48_out_value case=153 actual=%h expected=%h",round48_out_value,32'hff78fff5); end
154: begin if (round48_out_value !== 32'hff548985) $fatal(1,"NUMERICAL_round48_out_value case=154 actual=%h expected=%h",round48_out_value,32'hff548985); end
155: begin if (round48_out_value !== 32'h0209ac4e) $fatal(1,"NUMERICAL_round48_out_value case=155 actual=%h expected=%h",round48_out_value,32'h0209ac4e); end
156: begin if (round48_out_value !== 32'hfe2205c7) $fatal(1,"NUMERICAL_round48_out_value case=156 actual=%h expected=%h",round48_out_value,32'hfe2205c7); end
157: begin if (round48_out_value !== 32'h00a5ab78) $fatal(1,"NUMERICAL_round48_out_value case=157 actual=%h expected=%h",round48_out_value,32'h00a5ab78); end
158: begin if (round48_out_value !== 32'hff26585a) $fatal(1,"NUMERICAL_round48_out_value case=158 actual=%h expected=%h",round48_out_value,32'hff26585a); end
159: begin if (round48_out_value !== 32'hffdf75b1) $fatal(1,"NUMERICAL_round48_out_value case=159 actual=%h expected=%h",round48_out_value,32'hffdf75b1); end
160: begin if (round48_out_value !== 32'hff150372) $fatal(1,"NUMERICAL_round48_out_value case=160 actual=%h expected=%h",round48_out_value,32'hff150372); end
161: begin if (round48_out_value !== 32'hffd0d3be) $fatal(1,"NUMERICAL_round48_out_value case=161 actual=%h expected=%h",round48_out_value,32'hffd0d3be); end
162: begin if (round48_out_value !== 32'hff0347b6) $fatal(1,"NUMERICAL_round48_out_value case=162 actual=%h expected=%h",round48_out_value,32'hff0347b6); end
163: begin if (round48_out_value !== 32'hfe060a2b) $fatal(1,"NUMERICAL_round48_out_value case=163 actual=%h expected=%h",round48_out_value,32'hfe060a2b); end
164: begin if (round48_out_value !== 32'h004aac7d) $fatal(1,"NUMERICAL_round48_out_value case=164 actual=%h expected=%h",round48_out_value,32'h004aac7d); end
endcase
held={1'b1,{round48_out_value}};
@(negedge clk); round48_iv=0;
repeat(3) begin @(posedge clk);
if ({round48_ov,{round48_out_value}} !== held) $fatal(1,"STALLED_round48");
#1;
if ({round48_ov,{round48_out_value}} !== held) $fatal(1,"STALLED_POST_round48");
end
@(negedge clk); round48_or=1; @(posedge clk); #1;
if (round48_ov !== 1'b0) $fatal(1,"RETIRE_round48");
@(negedge clk); round48_or=0;
comparisons=comparisons+1;
end endtask
task automatic run_round96(input integer index);
reg [32:0] held;
integer elapsed;
begin
@(negedge clk);
while (round96_ir !== 1'b1) @(negedge clk);
case(index)
0: begin round96_in_value=128'h00000000000000000000000000000000; end
1: begin round96_in_value=128'h80000000000000000000000000000000; end
2: begin round96_in_value=128'h7fffffffffffffffffffffffffffffff; end
3: begin round96_in_value=128'h800000007fffffffffffffffffffffff; end
4: begin round96_in_value=128'h80000000800000000000000000000000; end
5: begin round96_in_value=128'h80000000800000000000000000000001; end
6: begin round96_in_value=128'hfffffffe7fffffffffffffffffffffff; end
7: begin round96_in_value=128'hfffffffe800000000000000000000000; end
8: begin round96_in_value=128'hfffffffe800000000000000000000001; end
9: begin round96_in_value=128'hffffffff7fffffffffffffffffffffff; end
10: begin round96_in_value=128'hffffffff800000000000000000000000; end
11: begin round96_in_value=128'hffffffff800000000000000000000001; end
12: begin round96_in_value=128'h000000007fffffffffffffffffffffff; end
13: begin round96_in_value=128'h00000000800000000000000000000000; end
14: begin round96_in_value=128'h00000000800000000000000000000001; end
15: begin round96_in_value=128'h000000017fffffffffffffffffffffff; end
16: begin round96_in_value=128'h00000001800000000000000000000000; end
17: begin round96_in_value=128'h00000001800000000000000000000001; end
18: begin round96_in_value=128'h7fffffff7fffffffffffffffffffffff; end
19: begin round96_in_value=128'h7fffffff800000000000000000000000; end
20: begin round96_in_value=128'h7fffffff800000000000000000000001; end
default: $fatal(1,"BAD_CASE");
endcase
round96_iv=1; @(posedge clk);
if (round96_ir !== 1'b1) $fatal(1,"ACCEPT_round96");
#1; elapsed=0;
repeat (0) begin
if (round96_ov !== 1'b0) $fatal(1,"EARLY_VALID_round96 edge=%0d",elapsed);
@(negedge clk); round96_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
if (round96_ov !== 1'b1) $fatal(1,"LATE_VALID_round96 edge=%0d",elapsed);
case(index)
0: begin if (round96_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round96_out_value case=0 actual=%h expected=%h",round96_out_value,32'h00000000); end
1: begin if (round96_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round96_out_value case=1 actual=%h expected=%h",round96_out_value,32'h80000000); end
2: begin if (round96_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round96_out_value case=2 actual=%h expected=%h",round96_out_value,32'h7fffffff); end
3: begin if (round96_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round96_out_value case=3 actual=%h expected=%h",round96_out_value,32'h80000000); end
4: begin if (round96_out_value !== 32'h80000000) $fatal(1,"NUMERICAL_round96_out_value case=4 actual=%h expected=%h",round96_out_value,32'h80000000); end
5: begin if (round96_out_value !== 32'h80000001) $fatal(1,"NUMERICAL_round96_out_value case=5 actual=%h expected=%h",round96_out_value,32'h80000001); end
6: begin if (round96_out_value !== 32'hfffffffe) $fatal(1,"NUMERICAL_round96_out_value case=6 actual=%h expected=%h",round96_out_value,32'hfffffffe); end
7: begin if (round96_out_value !== 32'hfffffffe) $fatal(1,"NUMERICAL_round96_out_value case=7 actual=%h expected=%h",round96_out_value,32'hfffffffe); end
8: begin if (round96_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round96_out_value case=8 actual=%h expected=%h",round96_out_value,32'hffffffff); end
9: begin if (round96_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round96_out_value case=9 actual=%h expected=%h",round96_out_value,32'hffffffff); end
10: begin if (round96_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_round96_out_value case=10 actual=%h expected=%h",round96_out_value,32'hffffffff); end
11: begin if (round96_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round96_out_value case=11 actual=%h expected=%h",round96_out_value,32'h00000000); end
12: begin if (round96_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_round96_out_value case=12 actual=%h expected=%h",round96_out_value,32'h00000000); end
13: begin if (round96_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round96_out_value case=13 actual=%h expected=%h",round96_out_value,32'h00000001); end
14: begin if (round96_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round96_out_value case=14 actual=%h expected=%h",round96_out_value,32'h00000001); end
15: begin if (round96_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_round96_out_value case=15 actual=%h expected=%h",round96_out_value,32'h00000001); end
16: begin if (round96_out_value !== 32'h00000002) $fatal(1,"NUMERICAL_round96_out_value case=16 actual=%h expected=%h",round96_out_value,32'h00000002); end
17: begin if (round96_out_value !== 32'h00000002) $fatal(1,"NUMERICAL_round96_out_value case=17 actual=%h expected=%h",round96_out_value,32'h00000002); end
18: begin if (round96_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round96_out_value case=18 actual=%h expected=%h",round96_out_value,32'h7fffffff); end
19: begin if (round96_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round96_out_value case=19 actual=%h expected=%h",round96_out_value,32'h7fffffff); end
20: begin if (round96_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_round96_out_value case=20 actual=%h expected=%h",round96_out_value,32'h7fffffff); end
endcase
held={1'b1,{round96_out_value}};
@(negedge clk); round96_iv=0;
repeat(3) begin @(posedge clk);
if ({round96_ov,{round96_out_value}} !== held) $fatal(1,"STALLED_round96");
#1;
if ({round96_ov,{round96_out_value}} !== held) $fatal(1,"STALLED_POST_round96");
end
@(negedge clk); round96_or=1; @(posedge clk); #1;
if (round96_ov !== 1'b0) $fatal(1,"RETIRE_round96");
@(negedge clk); round96_or=0;
comparisons=comparisons+1;
end endtask
task automatic run_exp(input integer index);
reg [26:0] held;
integer elapsed;
begin
@(negedge clk);
while (exp_ir !== 1'b1) @(negedge clk);
case(index)
0: begin exp_in_x=33'h000000000; end
1: begin exp_in_x=33'h000000001; end
2: begin exp_in_x=33'h1ffffffff; end
3: begin exp_in_x=33'h1ffff0000; end
4: begin exp_in_x=33'h1fff00000; end
5: begin exp_in_x=33'h1ffefffff; end
6: begin exp_in_x=33'h180000000; end
7: begin exp_in_x=33'h07fffffff; end
8: begin exp_in_x=33'h1fff93a2f; end
9: begin exp_in_x=33'h1fff39398; end
10: begin exp_in_x=33'h1fff9c6a5; end
11: begin exp_in_x=33'h1fff0a442; end
12: begin exp_in_x=33'h1fffc83b9; end
13: begin exp_in_x=33'h1fffa6b55; end
14: begin exp_in_x=33'h1fff7209f; end
15: begin exp_in_x=33'h1fffddb75; end
16: begin exp_in_x=33'h1fff30354; end
17: begin exp_in_x=33'h1fff9589f; end
18: begin exp_in_x=33'h1fff39a76; end
19: begin exp_in_x=33'h1fff8a922; end
20: begin exp_in_x=33'h1fff54f8c; end
21: begin exp_in_x=33'h1fff4e063; end
22: begin exp_in_x=33'h1fff59ea5; end
23: begin exp_in_x=33'h1fff2da69; end
24: begin exp_in_x=33'h1fff87d08; end
25: begin exp_in_x=33'h1fffdcc38; end
26: begin exp_in_x=33'h1fffb4157; end
27: begin exp_in_x=33'h1fff5a71f; end
28: begin exp_in_x=33'h1fffe52eb; end
29: begin exp_in_x=33'h1fff8ebcc; end
30: begin exp_in_x=33'h1fff22375; end
31: begin exp_in_x=33'h1fffe6689; end
32: begin exp_in_x=33'h1fff4c779; end
33: begin exp_in_x=33'h1fffcf8f7; end
34: begin exp_in_x=33'h1fff8cb69; end
35: begin exp_in_x=33'h1fffc173d; end
36: begin exp_in_x=33'h1fff09320; end
37: begin exp_in_x=33'h1fffb6200; end
38: begin exp_in_x=33'h1fff41165; end
39: begin exp_in_x=33'h1fff1b315; end
default: $fatal(1,"BAD_CASE");
endcase
exp_iv=1; @(posedge clk);
if (exp_ir !== 1'b1) $fatal(1,"ACCEPT_exp");
#1; elapsed=0;
while (exp_ov !== 1'b1) begin
if (exp_ov !== 1'b0) $fatal(1,"VALID_XZ_exp");
@(negedge clk); exp_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
case(index)
0: begin if (exp_out_value !== 25'h1000000) $fatal(1,"NUMERICAL_exp_out_value case=0 actual=%h expected=%h",exp_out_value,25'h1000000); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=0 actual=%h expected=%h",exp_out_error,1'h0); end
1: begin if (exp_out_value !== 25'h1000000) $fatal(1,"NUMERICAL_exp_out_value case=1 actual=%h expected=%h",exp_out_value,25'h1000000); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=1 actual=%h expected=%h",exp_out_error,1'h0); end
2: begin if (exp_out_value !== 25'h0ffff00) $fatal(1,"NUMERICAL_exp_out_value case=2 actual=%h expected=%h",exp_out_value,25'h0ffff00); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=2 actual=%h expected=%h",exp_out_error,1'h0); end
3: begin if (exp_out_value !== 25'h05e2d59) $fatal(1,"NUMERICAL_exp_out_value case=3 actual=%h expected=%h",exp_out_value,25'h05e2d59); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=3 actual=%h expected=%h",exp_out_error,1'h0); end
4: begin if (exp_out_value !== 25'h0000001) $fatal(1,"NUMERICAL_exp_out_value case=4 actual=%h expected=%h",exp_out_value,25'h0000001); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=4 actual=%h expected=%h",exp_out_error,1'h0); end
5: begin if (exp_out_value !== 25'h0000000) $fatal(1,"NUMERICAL_exp_out_value case=5 actual=%h expected=%h",exp_out_value,25'h0000000); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=5 actual=%h expected=%h",exp_out_error,1'h0); end
6: begin if (exp_out_value !== 25'h0000000) $fatal(1,"NUMERICAL_exp_out_value case=6 actual=%h expected=%h",exp_out_value,25'h0000000); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=6 actual=%h expected=%h",exp_out_error,1'h0); end
7: begin if (exp_out_value !== 25'h1000000) $fatal(1,"NUMERICAL_exp_out_value case=7 actual=%h expected=%h",exp_out_value,25'h1000000); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=7 actual=%h expected=%h",exp_out_error,1'h0); end
8: begin if (exp_out_value !== 25'h0004b02) $fatal(1,"NUMERICAL_exp_out_value case=8 actual=%h expected=%h",exp_out_value,25'h0004b02); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=8 actual=%h expected=%h",exp_out_error,1'h0); end
9: begin if (exp_out_value !== 25'h0000043) $fatal(1,"NUMERICAL_exp_out_value case=9 actual=%h expected=%h",exp_out_value,25'h0000043); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=9 actual=%h expected=%h",exp_out_error,1'h0); end
10: begin if (exp_out_value !== 25'h00081d8) $fatal(1,"NUMERICAL_exp_out_value case=10 actual=%h expected=%h",exp_out_value,25'h00081d8); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=10 actual=%h expected=%h",exp_out_error,1'h0); end
11: begin if (exp_out_value !== 25'h0000003) $fatal(1,"NUMERICAL_exp_out_value case=11 actual=%h expected=%h",exp_out_value,25'h0000003); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=11 actual=%h expected=%h",exp_out_error,1'h0); end
12: begin if (exp_out_value !== 25'h007d801) $fatal(1,"NUMERICAL_exp_out_value case=12 actual=%h expected=%h",exp_out_value,25'h007d801); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=12 actual=%h expected=%h",exp_out_error,1'h0); end
13: begin if (exp_out_value !== 25'h000f70e) $fatal(1,"NUMERICAL_exp_out_value case=13 actual=%h expected=%h",exp_out_value,25'h000f70e); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=13 actual=%h expected=%h",exp_out_error,1'h0); end
14: begin if (exp_out_value !== 25'h000092f) $fatal(1,"NUMERICAL_exp_out_value case=14 actual=%h expected=%h",exp_out_value,25'h000092f); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=14 actual=%h expected=%h",exp_out_error,1'h0); end
15: begin if (exp_out_value !== 25'h01e097b) $fatal(1,"NUMERICAL_exp_out_value case=15 actual=%h expected=%h",exp_out_value,25'h01e097b); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=15 actual=%h expected=%h",exp_out_error,1'h0); end
16: begin if (exp_out_value !== 25'h0000026) $fatal(1,"NUMERICAL_exp_out_value case=16 actual=%h expected=%h",exp_out_value,25'h0000026); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=16 actual=%h expected=%h",exp_out_error,1'h0); end
17: begin if (exp_out_value !== 25'h000547b) $fatal(1,"NUMERICAL_exp_out_value case=17 actual=%h expected=%h",exp_out_value,25'h000547b); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=17 actual=%h expected=%h",exp_out_error,1'h0); end
18: begin if (exp_out_value !== 25'h0000045) $fatal(1,"NUMERICAL_exp_out_value case=18 actual=%h expected=%h",exp_out_value,25'h0000045); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=18 actual=%h expected=%h",exp_out_error,1'h0); end
19: begin if (exp_out_value !== 25'h0002a90) $fatal(1,"NUMERICAL_exp_out_value case=19 actual=%h expected=%h",exp_out_value,25'h0002a90); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=19 actual=%h expected=%h",exp_out_error,1'h0); end
20: begin if (exp_out_value !== 25'h000017e) $fatal(1,"NUMERICAL_exp_out_value case=20 actual=%h expected=%h",exp_out_value,25'h000017e); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=20 actual=%h expected=%h",exp_out_error,1'h0); end
21: begin if (exp_out_value !== 25'h00000f7) $fatal(1,"NUMERICAL_exp_out_value case=21 actual=%h expected=%h",exp_out_value,25'h00000f7); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=21 actual=%h expected=%h",exp_out_error,1'h0); end
22: begin if (exp_out_value !== 25'h0000208) $fatal(1,"NUMERICAL_exp_out_value case=22 actual=%h expected=%h",exp_out_value,25'h0000208); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=22 actual=%h expected=%h",exp_out_error,1'h0); end
23: begin if (exp_out_value !== 25'h0000020) $fatal(1,"NUMERICAL_exp_out_value case=23 actual=%h expected=%h",exp_out_value,25'h0000020); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=23 actual=%h expected=%h",exp_out_error,1'h0); end
24: begin if (exp_out_value !== 25'h00023d4) $fatal(1,"NUMERICAL_exp_out_value case=24 actual=%h expected=%h",exp_out_value,25'h00023d4); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=24 actual=%h expected=%h",exp_out_error,1'h0); end
25: begin if (exp_out_value !== 25'h01c4d20) $fatal(1,"NUMERICAL_exp_out_value case=25 actual=%h expected=%h",exp_out_value,25'h01c4d20); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=25 actual=%h expected=%h",exp_out_error,1'h0); end
26: begin if (exp_out_value !== 25'h00239fa) $fatal(1,"NUMERICAL_exp_out_value case=26 actual=%h expected=%h",exp_out_value,25'h00239fa); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=26 actual=%h expected=%h",exp_out_error,1'h0); end
27: begin if (exp_out_value !== 25'h000021a) $fatal(1,"NUMERICAL_exp_out_value case=27 actual=%h expected=%h",exp_out_value,25'h000021a); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=27 actual=%h expected=%h",exp_out_error,1'h0); end
28: begin if (exp_out_value !== 25'h02fe5e9) $fatal(1,"NUMERICAL_exp_out_value case=28 actual=%h expected=%h",exp_out_value,25'h02fe5e9); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=28 actual=%h expected=%h",exp_out_error,1'h0); end
29: begin if (exp_out_value !== 25'h0003739) $fatal(1,"NUMERICAL_exp_out_value case=29 actual=%h expected=%h",exp_out_value,25'h0003739); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=29 actual=%h expected=%h",exp_out_error,1'h0); end
30: begin if (exp_out_value !== 25'h0000010) $fatal(1,"NUMERICAL_exp_out_value case=30 actual=%h expected=%h",exp_out_value,25'h0000010); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=30 actual=%h expected=%h",exp_out_error,1'h0); end
31: begin if (exp_out_value !== 25'h033b67a) $fatal(1,"NUMERICAL_exp_out_value case=31 actual=%h expected=%h",exp_out_value,25'h033b67a); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=31 actual=%h expected=%h",exp_out_error,1'h0); end
32: begin if (exp_out_value !== 25'h00000e0) $fatal(1,"NUMERICAL_exp_out_value case=32 actual=%h expected=%h",exp_out_value,25'h00000e0); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=32 actual=%h expected=%h",exp_out_error,1'h0); end
33: begin if (exp_out_value !== 25'h00c6666) $fatal(1,"NUMERICAL_exp_out_value case=33 actual=%h expected=%h",exp_out_value,25'h00c6666); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=33 actual=%h expected=%h",exp_out_error,1'h0); end
34: begin if (exp_out_value !== 25'h00030a9) $fatal(1,"NUMERICAL_exp_out_value case=34 actual=%h expected=%h",exp_out_value,25'h00030a9); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=34 actual=%h expected=%h",exp_out_error,1'h0); end
35: begin if (exp_out_value !== 25'h0052264) $fatal(1,"NUMERICAL_exp_out_value case=35 actual=%h expected=%h",exp_out_value,25'h0052264); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=35 actual=%h expected=%h",exp_out_error,1'h0); end
36: begin if (exp_out_value !== 25'h0000003) $fatal(1,"NUMERICAL_exp_out_value case=36 actual=%h expected=%h",exp_out_value,25'h0000003); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=36 actual=%h expected=%h",exp_out_error,1'h0); end
37: begin if (exp_out_value !== 25'h0028788) $fatal(1,"NUMERICAL_exp_out_value case=37 actual=%h expected=%h",exp_out_value,25'h0028788); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=37 actual=%h expected=%h",exp_out_error,1'h0); end
38: begin if (exp_out_value !== 25'h000006e) $fatal(1,"NUMERICAL_exp_out_value case=38 actual=%h expected=%h",exp_out_value,25'h000006e); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=38 actual=%h expected=%h",exp_out_error,1'h0); end
39: begin if (exp_out_value !== 25'h000000a) $fatal(1,"NUMERICAL_exp_out_value case=39 actual=%h expected=%h",exp_out_value,25'h000000a); if (exp_out_error !== 1'h0) $fatal(1,"NUMERICAL_exp_out_error case=39 actual=%h expected=%h",exp_out_error,1'h0); end
endcase
held={1'b1,{exp_out_value,exp_out_error}};
@(negedge clk); exp_iv=0;
repeat(3) begin @(posedge clk);
if ({exp_ov,{exp_out_value,exp_out_error}} !== held) $fatal(1,"STALLED_exp");
#1;
if ({exp_ov,{exp_out_value,exp_out_error}} !== held) $fatal(1,"STALLED_POST_exp");
end
@(negedge clk); exp_or=1; @(posedge clk); #1;
if (exp_ov !== 1'b0) $fatal(1,"RETIRE_exp");
@(negedge clk); exp_or=0;
comparisons=comparisons+1;
end endtask
task automatic run_silu(input integer index);
reg [33:0] held;
integer elapsed;
begin
@(negedge clk);
while (silu_ir !== 1'b1) @(negedge clk);
case(index)
0: begin silu_in_x=32'h00000000; end
1: begin silu_in_x=32'h00000001; end
2: begin silu_in_x=32'hffffffff; end
3: begin silu_in_x=32'hffff0000; end
4: begin silu_in_x=32'hfff00000; end
5: begin silu_in_x=32'hffefffff; end
6: begin silu_in_x=32'h80000000; end
7: begin silu_in_x=32'h7fffffff; end
8: begin silu_in_x=32'hfff93a2f; end
9: begin silu_in_x=32'hfff39398; end
10: begin silu_in_x=32'hfff9c6a5; end
11: begin silu_in_x=32'hfff0a442; end
12: begin silu_in_x=32'hfffc83b9; end
13: begin silu_in_x=32'hfffa6b55; end
14: begin silu_in_x=32'hfff7209f; end
15: begin silu_in_x=32'hfffddb75; end
16: begin silu_in_x=32'hfff30354; end
17: begin silu_in_x=32'hfff9589f; end
18: begin silu_in_x=32'hfff39a76; end
19: begin silu_in_x=32'hfff8a922; end
20: begin silu_in_x=32'hfff54f8c; end
21: begin silu_in_x=32'hfff4e063; end
22: begin silu_in_x=32'hfff59ea5; end
23: begin silu_in_x=32'hfff2da69; end
24: begin silu_in_x=32'hfff87d08; end
25: begin silu_in_x=32'hfffdcc38; end
26: begin silu_in_x=32'hfffb4157; end
27: begin silu_in_x=32'hfff5a71f; end
28: begin silu_in_x=32'hfffe52eb; end
29: begin silu_in_x=32'hfff8ebcc; end
30: begin silu_in_x=32'hfff22375; end
31: begin silu_in_x=32'hfffe6689; end
32: begin silu_in_x=32'hfff4c779; end
33: begin silu_in_x=32'hfffcf8f7; end
34: begin silu_in_x=32'hfff8cb69; end
35: begin silu_in_x=32'hfffc173d; end
36: begin silu_in_x=32'hfff09320; end
37: begin silu_in_x=32'hfffb6200; end
38: begin silu_in_x=32'hfff41165; end
39: begin silu_in_x=32'hfff1b315; end
40: begin silu_in_x=32'h00000000; end
41: begin silu_in_x=32'hffffffff; end
42: begin silu_in_x=32'h00000001; end
43: begin silu_in_x=32'h00010000; end
44: begin silu_in_x=32'h00100000; end
45: begin silu_in_x=32'h00100001; end
46: begin silu_in_x=32'h80000001; end
47: begin silu_in_x=32'h0006c5d1; end
48: begin silu_in_x=32'h000c6c68; end
49: begin silu_in_x=32'h0006395b; end
50: begin silu_in_x=32'h000f5bbe; end
51: begin silu_in_x=32'h00037c47; end
52: begin silu_in_x=32'h000594ab; end
53: begin silu_in_x=32'h0008df61; end
54: begin silu_in_x=32'h0002248b; end
55: begin silu_in_x=32'h000cfcac; end
56: begin silu_in_x=32'h0006a761; end
57: begin silu_in_x=32'h000c658a; end
58: begin silu_in_x=32'h000756de; end
59: begin silu_in_x=32'h000ab074; end
60: begin silu_in_x=32'h000b1f9d; end
61: begin silu_in_x=32'h000a615b; end
62: begin silu_in_x=32'h000d2597; end
63: begin silu_in_x=32'h000782f8; end
64: begin silu_in_x=32'h000233c8; end
65: begin silu_in_x=32'h0004bea9; end
66: begin silu_in_x=32'h000a58e1; end
67: begin silu_in_x=32'h0001ad15; end
68: begin silu_in_x=32'h00071434; end
69: begin silu_in_x=32'h000ddc8b; end
70: begin silu_in_x=32'h00019977; end
71: begin silu_in_x=32'h000b3887; end
72: begin silu_in_x=32'h00030709; end
73: begin silu_in_x=32'h00073497; end
74: begin silu_in_x=32'h0003e8c3; end
75: begin silu_in_x=32'h000f6ce0; end
76: begin silu_in_x=32'h00049e00; end
77: begin silu_in_x=32'h000bee9b; end
78: begin silu_in_x=32'h000e4ceb; end
default: $fatal(1,"BAD_CASE");
endcase
silu_iv=1; @(posedge clk);
if (silu_ir !== 1'b1) $fatal(1,"ACCEPT_silu");
#1; elapsed=0;
while (silu_ov !== 1'b1) begin
if (silu_ov !== 1'b0) $fatal(1,"VALID_XZ_silu");
@(negedge clk); silu_iv=0; @(posedge clk); #1; elapsed=elapsed+1;
end
case(index)
0: begin if (silu_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_silu_out_value case=0 actual=%h expected=%h",silu_out_value,32'h00000000); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=0 actual=%h expected=%h",silu_out_error,1'h0); end
1: begin if (silu_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_silu_out_value case=1 actual=%h expected=%h",silu_out_value,32'h00000001); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=1 actual=%h expected=%h",silu_out_error,1'h0); end
2: begin if (silu_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_silu_out_value case=2 actual=%h expected=%h",silu_out_value,32'h00000000); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=2 actual=%h expected=%h",silu_out_error,1'h0); end
3: begin if (silu_out_value !== 32'hffffbb27) $fatal(1,"NUMERICAL_silu_out_value case=3 actual=%h expected=%h",silu_out_value,32'hffffbb27); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=3 actual=%h expected=%h",silu_out_error,1'h0); end
4: begin if (silu_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_silu_out_value case=4 actual=%h expected=%h",silu_out_value,32'h00000000); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=4 actual=%h expected=%h",silu_out_error,1'h0); end
5: begin if (silu_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_silu_out_value case=5 actual=%h expected=%h",silu_out_value,32'h00000000); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=5 actual=%h expected=%h",silu_out_error,1'h0); end
6: begin if (silu_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_silu_out_value case=6 actual=%h expected=%h",silu_out_value,32'h00000000); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=6 actual=%h expected=%h",silu_out_error,1'h0); end
7: begin if (silu_out_value !== 32'h7fffffff) $fatal(1,"NUMERICAL_silu_out_value case=7 actual=%h expected=%h",silu_out_value,32'h7fffffff); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=7 actual=%h expected=%h",silu_out_error,1'h0); end
8: begin if (silu_out_value !== 32'hfffffe05) $fatal(1,"NUMERICAL_silu_out_value case=8 actual=%h expected=%h",silu_out_value,32'hfffffe05); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=8 actual=%h expected=%h",silu_out_error,1'h0); end
9: begin if (silu_out_value !== 32'hfffffffd) $fatal(1,"NUMERICAL_silu_out_value case=9 actual=%h expected=%h",silu_out_value,32'hfffffffd); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=9 actual=%h expected=%h",silu_out_error,1'h0); end
10: begin if (silu_out_value !== 32'hfffffcd9) $fatal(1,"NUMERICAL_silu_out_value case=10 actual=%h expected=%h",silu_out_value,32'hfffffcd9); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=10 actual=%h expected=%h",silu_out_error,1'h0); end
11: begin if (silu_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_silu_out_value case=11 actual=%h expected=%h",silu_out_value,32'h00000000); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=11 actual=%h expected=%h",silu_out_error,1'h0); end
12: begin if (silu_out_value !== 32'hffffe579) $fatal(1,"NUMERICAL_silu_out_value case=12 actual=%h expected=%h",silu_out_value,32'hffffe579); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=12 actual=%h expected=%h",silu_out_error,1'h0); end
13: begin if (silu_out_value !== 32'hfffffaa2) $fatal(1,"NUMERICAL_silu_out_value case=13 actual=%h expected=%h",silu_out_value,32'hfffffaa2); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=13 actual=%h expected=%h",silu_out_error,1'h0); end
14: begin if (silu_out_value !== 32'hffffffaf) $fatal(1,"NUMERICAL_silu_out_value case=14 actual=%h expected=%h",silu_out_value,32'hffffffaf); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=14 actual=%h expected=%h",silu_out_error,1'h0); end
15: begin if (silu_out_value !== 32'hffffc666) $fatal(1,"NUMERICAL_silu_out_value case=15 actual=%h expected=%h",silu_out_value,32'hffffc666); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=15 actual=%h expected=%h",silu_out_error,1'h0); end
16: begin if (silu_out_value !== 32'hfffffffe) $fatal(1,"NUMERICAL_silu_out_value case=16 actual=%h expected=%h",silu_out_value,32'hfffffffe); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=16 actual=%h expected=%h",silu_out_error,1'h0); end
17: begin if (silu_out_value !== 32'hfffffdcf) $fatal(1,"NUMERICAL_silu_out_value case=17 actual=%h expected=%h",silu_out_value,32'hfffffdcf); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=17 actual=%h expected=%h",silu_out_error,1'h0); end
18: begin if (silu_out_value !== 32'hfffffffd) $fatal(1,"NUMERICAL_silu_out_value case=18 actual=%h expected=%h",silu_out_value,32'hfffffffd); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=18 actual=%h expected=%h",silu_out_error,1'h0); end
19: begin if (silu_out_value !== 32'hfffffec8) $fatal(1,"NUMERICAL_silu_out_value case=19 actual=%h expected=%h",silu_out_value,32'hfffffec8); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=19 actual=%h expected=%h",silu_out_error,1'h0); end
20: begin if (silu_out_value !== 32'hfffffff0) $fatal(1,"NUMERICAL_silu_out_value case=20 actual=%h expected=%h",silu_out_value,32'hfffffff0); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=20 actual=%h expected=%h",silu_out_error,1'h0); end
21: begin if (silu_out_value !== 32'hfffffff5) $fatal(1,"NUMERICAL_silu_out_value case=21 actual=%h expected=%h",silu_out_value,32'hfffffff5); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=21 actual=%h expected=%h",silu_out_error,1'h0); end
22: begin if (silu_out_value !== 32'hffffffeb) $fatal(1,"NUMERICAL_silu_out_value case=22 actual=%h expected=%h",silu_out_value,32'hffffffeb); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=22 actual=%h expected=%h",silu_out_error,1'h0); end
23: begin if (silu_out_value !== 32'hfffffffe) $fatal(1,"NUMERICAL_silu_out_value case=23 actual=%h expected=%h",silu_out_value,32'hfffffffe); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=23 actual=%h expected=%h",silu_out_error,1'h0); end
24: begin if (silu_out_value !== 32'hfffffef3) $fatal(1,"NUMERICAL_silu_out_value case=24 actual=%h expected=%h",silu_out_value,32'hfffffef3); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=24 actual=%h expected=%h",silu_out_error,1'h0); end
25: begin if (silu_out_value !== 32'hffffc7e1) $fatal(1,"NUMERICAL_silu_out_value case=25 actual=%h expected=%h",silu_out_value,32'hffffc7e1); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=25 actual=%h expected=%h",silu_out_error,1'h0); end
26: begin if (silu_out_value !== 32'hfffff587) $fatal(1,"NUMERICAL_silu_out_value case=26 actual=%h expected=%h",silu_out_value,32'hfffff587); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=26 actual=%h expected=%h",silu_out_error,1'h0); end
27: begin if (silu_out_value !== 32'hffffffea) $fatal(1,"NUMERICAL_silu_out_value case=27 actual=%h expected=%h",silu_out_value,32'hffffffea); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=27 actual=%h expected=%h",silu_out_error,1'h0); end
28: begin if (silu_out_value !== 32'hffffbc5f) $fatal(1,"NUMERICAL_silu_out_value case=28 actual=%h expected=%h",silu_out_value,32'hffffbc5f); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=28 actual=%h expected=%h",silu_out_error,1'h0); end
29: begin if (silu_out_value !== 32'hfffffe79) $fatal(1,"NUMERICAL_silu_out_value case=29 actual=%h expected=%h",silu_out_value,32'hfffffe79); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=29 actual=%h expected=%h",silu_out_error,1'h0); end
30: begin if (silu_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_silu_out_value case=30 actual=%h expected=%h",silu_out_value,32'hffffffff); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=30 actual=%h expected=%h",silu_out_error,1'h0); end
31: begin if (silu_out_value !== 32'hffffbb30) $fatal(1,"NUMERICAL_silu_out_value case=31 actual=%h expected=%h",silu_out_value,32'hffffbb30); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=31 actual=%h expected=%h",silu_out_error,1'h0); end
32: begin if (silu_out_value !== 32'hfffffff6) $fatal(1,"NUMERICAL_silu_out_value case=32 actual=%h expected=%h",silu_out_value,32'hfffffff6); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=32 actual=%h expected=%h",silu_out_error,1'h0); end
33: begin if (silu_out_value !== 32'hffffdc32) $fatal(1,"NUMERICAL_silu_out_value case=33 actual=%h expected=%h",silu_out_value,32'hffffdc32); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=33 actual=%h expected=%h",silu_out_error,1'h0); end
34: begin if (silu_out_value !== 32'hfffffea2) $fatal(1,"NUMERICAL_silu_out_value case=34 actual=%h expected=%h",silu_out_value,32'hfffffea2); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=34 actual=%h expected=%h",silu_out_error,1'h0); end
35: begin if (silu_out_value !== 32'hffffec53) $fatal(1,"NUMERICAL_silu_out_value case=35 actual=%h expected=%h",silu_out_value,32'hffffec53); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=35 actual=%h expected=%h",silu_out_error,1'h0); end
36: begin if (silu_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_silu_out_value case=36 actual=%h expected=%h",silu_out_value,32'h00000000); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=36 actual=%h expected=%h",silu_out_error,1'h0); end
37: begin if (silu_out_value !== 32'hfffff46f) $fatal(1,"NUMERICAL_silu_out_value case=37 actual=%h expected=%h",silu_out_value,32'hfffff46f); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=37 actual=%h expected=%h",silu_out_error,1'h0); end
38: begin if (silu_out_value !== 32'hfffffffb) $fatal(1,"NUMERICAL_silu_out_value case=38 actual=%h expected=%h",silu_out_value,32'hfffffffb); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=38 actual=%h expected=%h",silu_out_error,1'h0); end
39: begin if (silu_out_value !== 32'hffffffff) $fatal(1,"NUMERICAL_silu_out_value case=39 actual=%h expected=%h",silu_out_value,32'hffffffff); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=39 actual=%h expected=%h",silu_out_error,1'h0); end
40: begin if (silu_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_silu_out_value case=40 actual=%h expected=%h",silu_out_value,32'h00000000); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=40 actual=%h expected=%h",silu_out_error,1'h0); end
41: begin if (silu_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_silu_out_value case=41 actual=%h expected=%h",silu_out_value,32'h00000000); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=41 actual=%h expected=%h",silu_out_error,1'h0); end
42: begin if (silu_out_value !== 32'h00000001) $fatal(1,"NUMERICAL_silu_out_value case=42 actual=%h expected=%h",silu_out_value,32'h00000001); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=42 actual=%h expected=%h",silu_out_error,1'h0); end
43: begin if (silu_out_value !== 32'h0000bb27) $fatal(1,"NUMERICAL_silu_out_value case=43 actual=%h expected=%h",silu_out_value,32'h0000bb27); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=43 actual=%h expected=%h",silu_out_error,1'h0); end
44: begin if (silu_out_value !== 32'h00100000) $fatal(1,"NUMERICAL_silu_out_value case=44 actual=%h expected=%h",silu_out_value,32'h00100000); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=44 actual=%h expected=%h",silu_out_error,1'h0); end
45: begin if (silu_out_value !== 32'h00100001) $fatal(1,"NUMERICAL_silu_out_value case=45 actual=%h expected=%h",silu_out_value,32'h00100001); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=45 actual=%h expected=%h",silu_out_error,1'h0); end
46: begin if (silu_out_value !== 32'h00000000) $fatal(1,"NUMERICAL_silu_out_value case=46 actual=%h expected=%h",silu_out_value,32'h00000000); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=46 actual=%h expected=%h",silu_out_error,1'h0); end
47: begin if (silu_out_value !== 32'h0006c3d6) $fatal(1,"NUMERICAL_silu_out_value case=47 actual=%h expected=%h",silu_out_value,32'h0006c3d6); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=47 actual=%h expected=%h",silu_out_error,1'h0); end
48: begin if (silu_out_value !== 32'h000c6c65) $fatal(1,"NUMERICAL_silu_out_value case=48 actual=%h expected=%h",silu_out_value,32'h000c6c65); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=48 actual=%h expected=%h",silu_out_error,1'h0); end
49: begin if (silu_out_value !== 32'h00063634) $fatal(1,"NUMERICAL_silu_out_value case=49 actual=%h expected=%h",silu_out_value,32'h00063634); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=49 actual=%h expected=%h",silu_out_error,1'h0); end
50: begin if (silu_out_value !== 32'h000f5bbe) $fatal(1,"NUMERICAL_silu_out_value case=50 actual=%h expected=%h",silu_out_value,32'h000f5bbe); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=50 actual=%h expected=%h",silu_out_error,1'h0); end
51: begin if (silu_out_value !== 32'h000361c0) $fatal(1,"NUMERICAL_silu_out_value case=51 actual=%h expected=%h",silu_out_value,32'h000361c0); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=51 actual=%h expected=%h",silu_out_error,1'h0); end
52: begin if (silu_out_value !== 32'h00058f4d) $fatal(1,"NUMERICAL_silu_out_value case=52 actual=%h expected=%h",silu_out_value,32'h00058f4d); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=52 actual=%h expected=%h",silu_out_error,1'h0); end
53: begin if (silu_out_value !== 32'h0008df10) $fatal(1,"NUMERICAL_silu_out_value case=53 actual=%h expected=%h",silu_out_value,32'h0008df10); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=53 actual=%h expected=%h",silu_out_error,1'h0); end
54: begin if (silu_out_value !== 32'h0001eaf1) $fatal(1,"NUMERICAL_silu_out_value case=54 actual=%h expected=%h",silu_out_value,32'h0001eaf1); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=54 actual=%h expected=%h",silu_out_error,1'h0); end
55: begin if (silu_out_value !== 32'h000cfcaa) $fatal(1,"NUMERICAL_silu_out_value case=55 actual=%h expected=%h",silu_out_value,32'h000cfcaa); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=55 actual=%h expected=%h",silu_out_error,1'h0); end
56: begin if (silu_out_value !== 32'h0006a530) $fatal(1,"NUMERICAL_silu_out_value case=56 actual=%h expected=%h",silu_out_value,32'h0006a530); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=56 actual=%h expected=%h",silu_out_error,1'h0); end
57: begin if (silu_out_value !== 32'h000c6587) $fatal(1,"NUMERICAL_silu_out_value case=57 actual=%h expected=%h",silu_out_value,32'h000c6587); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=57 actual=%h expected=%h",silu_out_error,1'h0); end
58: begin if (silu_out_value !== 32'h000755a6) $fatal(1,"NUMERICAL_silu_out_value case=58 actual=%h expected=%h",silu_out_value,32'h000755a6); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=58 actual=%h expected=%h",silu_out_error,1'h0); end
59: begin if (silu_out_value !== 32'h000ab064) $fatal(1,"NUMERICAL_silu_out_value case=59 actual=%h expected=%h",silu_out_value,32'h000ab064); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=59 actual=%h expected=%h",silu_out_error,1'h0); end
60: begin if (silu_out_value !== 32'h000b1f92) $fatal(1,"NUMERICAL_silu_out_value case=60 actual=%h expected=%h",silu_out_value,32'h000b1f92); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=60 actual=%h expected=%h",silu_out_error,1'h0); end
61: begin if (silu_out_value !== 32'h000a6146) $fatal(1,"NUMERICAL_silu_out_value case=61 actual=%h expected=%h",silu_out_value,32'h000a6146); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=61 actual=%h expected=%h",silu_out_error,1'h0); end
62: begin if (silu_out_value !== 32'h000d2595) $fatal(1,"NUMERICAL_silu_out_value case=62 actual=%h expected=%h",silu_out_value,32'h000d2595); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=62 actual=%h expected=%h",silu_out_error,1'h0); end
63: begin if (silu_out_value !== 32'h000781eb) $fatal(1,"NUMERICAL_silu_out_value case=63 actual=%h expected=%h",silu_out_value,32'h000781eb); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=63 actual=%h expected=%h",silu_out_error,1'h0); end
64: begin if (silu_out_value !== 32'h0001fba9) $fatal(1,"NUMERICAL_silu_out_value case=64 actual=%h expected=%h",silu_out_value,32'h0001fba9); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=64 actual=%h expected=%h",silu_out_error,1'h0); end
65: begin if (silu_out_value !== 32'h0004b430) $fatal(1,"NUMERICAL_silu_out_value case=65 actual=%h expected=%h",silu_out_value,32'h0004b430); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=65 actual=%h expected=%h",silu_out_error,1'h0); end
66: begin if (silu_out_value !== 32'h000a58cb) $fatal(1,"NUMERICAL_silu_out_value case=66 actual=%h expected=%h",silu_out_value,32'h000a58cb); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=66 actual=%h expected=%h",silu_out_error,1'h0); end
67: begin if (silu_out_value !== 32'h00016974) $fatal(1,"NUMERICAL_silu_out_value case=67 actual=%h expected=%h",silu_out_value,32'h00016974); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=67 actual=%h expected=%h",silu_out_error,1'h0); end
68: begin if (silu_out_value !== 32'h000712ad) $fatal(1,"NUMERICAL_silu_out_value case=68 actual=%h expected=%h",silu_out_value,32'h000712ad); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=68 actual=%h expected=%h",silu_out_error,1'h0); end
69: begin if (silu_out_value !== 32'h000ddc8a) $fatal(1,"NUMERICAL_silu_out_value case=69 actual=%h expected=%h",silu_out_value,32'h000ddc8a); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=69 actual=%h expected=%h",silu_out_error,1'h0); end
70: begin if (silu_out_value !== 32'h000154a7) $fatal(1,"NUMERICAL_silu_out_value case=70 actual=%h expected=%h",silu_out_value,32'h000154a7); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=70 actual=%h expected=%h",silu_out_error,1'h0); end
71: begin if (silu_out_value !== 32'h000b387d) $fatal(1,"NUMERICAL_silu_out_value case=71 actual=%h expected=%h",silu_out_value,32'h000b387d); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=71 actual=%h expected=%h",silu_out_error,1'h0); end
72: begin if (silu_out_value !== 32'h0002e33b) $fatal(1,"NUMERICAL_silu_out_value case=72 actual=%h expected=%h",silu_out_value,32'h0002e33b); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=72 actual=%h expected=%h",silu_out_error,1'h0); end
73: begin if (silu_out_value !== 32'h00073339) $fatal(1,"NUMERICAL_silu_out_value case=73 actual=%h expected=%h",silu_out_value,32'h00073339); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=73 actual=%h expected=%h",silu_out_error,1'h0); end
74: begin if (silu_out_value !== 32'h0003d516) $fatal(1,"NUMERICAL_silu_out_value case=74 actual=%h expected=%h",silu_out_value,32'h0003d516); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=74 actual=%h expected=%h",silu_out_error,1'h0); end
75: begin if (silu_out_value !== 32'h000f6ce0) $fatal(1,"NUMERICAL_silu_out_value case=75 actual=%h expected=%h",silu_out_value,32'h000f6ce0); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=75 actual=%h expected=%h",silu_out_error,1'h0); end
76: begin if (silu_out_value !== 32'h0004926f) $fatal(1,"NUMERICAL_silu_out_value case=76 actual=%h expected=%h",silu_out_value,32'h0004926f); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=76 actual=%h expected=%h",silu_out_error,1'h0); end
77: begin if (silu_out_value !== 32'h000bee96) $fatal(1,"NUMERICAL_silu_out_value case=77 actual=%h expected=%h",silu_out_value,32'h000bee96); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=77 actual=%h expected=%h",silu_out_error,1'h0); end
78: begin if (silu_out_value !== 32'h000e4cea) $fatal(1,"NUMERICAL_silu_out_value case=78 actual=%h expected=%h",silu_out_value,32'h000e4cea); if (silu_out_error !== 1'h0) $fatal(1,"NUMERICAL_silu_out_error case=78 actual=%h expected=%h",silu_out_error,1'h0); end
endcase
held={1'b1,{silu_out_value,silu_out_error}};
@(negedge clk); silu_iv=0;
repeat(3) begin @(posedge clk);
if ({silu_ov,{silu_out_value,silu_out_error}} !== held) $fatal(1,"STALLED_silu");
#1;
if ({silu_ov,{silu_out_value,silu_out_error}} !== held) $fatal(1,"STALLED_POST_silu");
end
@(negedge clk); silu_or=1; @(posedge clk); #1;
if (silu_ov !== 1'b0) $fatal(1,"RETIRE_silu");
@(negedge clk); silu_or=0;
comparisons=comparisons+1;
end endtask
initial begin rst_n=0;
`ifdef VERILATOR
#1;
`else
#0;
`endif
check_reset(); repeat(2) @(negedge clk); #1; rst_n=1;
for (integer n=0;n<197;n=n+1) run_mul32(n);
for (integer n=0;n<365;n=n+1) run_mul96(n);
for (integer n=0;n<16;n=n+1) run_udiv(n);
for (integer n=0;n<33;n=n+1) run_sdiv(n);
for (integer n=0;n<12;n=n+1) run_root(n);
for (integer n=0;n<37;n=n+1) run_add0(n);
for (integer n=0;n<37;n=n+1) run_add1(n);
for (integer n=0;n<3;n=n+1) run_round0(n);
for (integer n=0;n<21;n=n+1) run_round16(n);
for (integer n=0;n<21;n=n+1) run_round24(n);
for (integer n=0;n<21;n=n+1) run_round32(n);
for (integer n=0;n<165;n=n+1) run_round48(n);
for (integer n=0;n<21;n=n+1) run_round96(n);
for (integer n=0;n<40;n=n+1) run_exp(n);
for (integer n=0;n<79;n=n+1) run_silu(n);
if (comparisons!=1068 || reset_samples<5) $fatal(1,"MISSING_COMPARISONS");
$display("SUMMARY numerical_comparisons=%0d reset_samples=%0d",comparisons,reset_samples);
$finish; end endmodule
