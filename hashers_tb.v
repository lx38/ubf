`timescale 1ns / 1ns

module tb ();

localparam clk_period   = 10; // clk period ns
localparam clk_delay    =  0; // clk initial delay
localparam SHA256_ROUNDS  = 64;

reg clk;    // clock
reg rst;    // sync reset

wire [319:0] hgfedcba [0:63+1];
assign hgfedcba[0] = md;

assign DATA[0] = 512'h01a23edc4f51a23edc4f51a23edc4f51_a23edc4f51a23edc4f51a23edc4f51a2_3edc4f51a23edc4f51a23edc4f51a23e_dc4f51a23edc4f51a23edc4f51a23ed0; //Igor

reg [511:0] DATA [0:3];
assign DATA[0] = 512'h01a23edc4f51a23edc4f51a23edc4f51_a23edc4f51a23edc4f51a23edc4f51a2_3edc4f51a23edc4f51a23edc4f51a23e_dc4f51a23edc4f51a23edc4f51a23ed0; //Igor

efgh efgh0 (.clk, .din(w[i]), .dout(w[i+1]));

always begin
  #(clk_delay);
  forever #(clk_period/2) clk = ~clk;
end

reg [24:0] clk_counter; 
always begin
  @(posedge clk);
  clk_counter <= clk_counter + 1;
end 

initial begin
  #0 clk  = 1'b0;
  clk_counter = 0;
  #1 rst = 1;
  @(posedge clk)
  #1 rst = 0;

  din = DATA;
  reference_data = REFERENCE;

  #(clk_period*100);
  $finish;
end

endmodule
