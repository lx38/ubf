// module abcdefgh (
//   input             clk, 
//   input      [31:0] wr, kr, 
//   input      [319:0] din,  
//   output reg [319:0] dout  
// );

// `include "sha256v2_func.vh"

// wire [31:0] a,b,c,d,e,f,g,h,ds,agwk; 
// assign {a,c,b,d,e,f,g,h,ds,agwk} = din;

// wire [31:0] calce = e1(e) +  ch(e,f,g) + agwk;
// wire [31:0] calca = e0(a) + maj(a,b,c) + ds;

// always @(posedge clk) begin: cmp_regs
//   ds <= e - c;
//   agwk <= wr + a + g + kr;
//   dout <= {calca,a,b,c, calce,e,f,g, ds, agwk};
// end

// endmodule

module efgh (
  input clk, 
  input      [31:0] agwk, 
  input      [95:0] din,  

  output reg [95:0] dout,
  output reg [31:0] hout,
  output reg [31:0] eout
);

`include "funcs.vh"

wire [31:0] e,f,g,calce; 
assign {e,f,g} = din;

assign calce = e1(e) + ch(e,f,g) + agwk;

always @(posedge clk) begin: efgh_regs
  dout <= {calce,e,f};
  hout <= g;
  eout <= calce;

end


endmodule

