`timescale 1ns / 1ns

module tb ();

localparam clk_period   = 10; // clk period ns
localparam clk_delay    =  0; // clk initial delay
localparam SHA256_ROUNDS  = 64;

reg clk;    // clock
reg rst;    // sync reset

always begin
  #(clk_delay);
  forever #(clk_period/2) clk = ~clk;
end

reg [24:0] clk_counter; 
always begin
  @(posedge clk);
  clk_counter <= clk_counter + 1;
end 

reg [95:0] din;
reg [31:0] agwk;
reg [95:0] dout; 
reg [31:0] hout;
reg [31:0] e;


efgh efgh0 (.clk, .din, .agwk, .dout, .hout, .eout(e));

initial begin
  #0 clk  = 1'b0;
  clk_counter = 0;
  @(posedge clk);

  agwk = 32'h87bb7a3d;
  din = 96'h238956e3_af5e1cba_a8a8881c; // expects c7253cdb   
  @(posedge clk);

  agwk = 32'h1b1914cf;
  din = 96'h9ebad54f_85b1c84a_72f4312b; // expects c7253cdb   
  @(posedge clk);

  agwk = 32'h87bb7a3d;
  din = 96'h238956e3_af5e1cba_a8a8881c; // expects c7253cdb   
  @(posedge clk);

  agwk = 32'h1b1914cf;
  din = 96'h9ebad54f_85b1c84a_72f4312b; // expects c7253cdb   
  @(posedge clk);

  $finish;
end

always @(posedge clk) begin
  $monitor("clk=%d\nagwk=0x%H efg=0x%H \nhout=0x%H dout=0x%H\n", clk_counter,agwk, din, hout, dout, );
end

// always @(posedge clk) begin
//   if (clk_counter == 1) begin
//   end

//   if (clk_counter == 2) begin
//     agwk1 = 32'h19f7d356;
//     agwk0 = 32'h1b1914cf;
//     din0 = 96'h9ebad54f_85b1c84a_72f4312b; // expects c7253cdb   
//   end
// end
initial
 begin
    $dumpfile("test.vcd");
    $dumpvars(0,tb);
 end


endmodule
