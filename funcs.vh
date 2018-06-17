// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// %% Project    : SHA256 Engine
// %% URL        : https://github.com/bwbw/sha256
// %% Author     : Dmitry Murzinov (idoka@bitware.com)
// %% Module     : function for sha256
// %% Description:
// %% Version    : 0.1
// %% Date       : $LastChangedDate$
// %% Copyright  : Gigahash Operations Ltd © 2018
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


////////////////////////////////////////////////////////////////////////////////
function [31:0] ch(
  input [31:0] x,
  input [31:0] y,
  input [31:0] z);
  begin
    ch = (x & y) ^ (~x & z); // z ^ (x & (y ^ z))
  end
endfunction

////////////////////////////////////////////////////////////////////////////////
function [31:0] maj(
  input [31:0] x,
  input [31:0] y,
  input [31:0] z);
  begin
    maj = (x & y) ^ (x & z) ^ (y & z); //(x & y) | (z & (x | y))
  end
endfunction

////////////////////////////////////////////////////////////////////////////////
function [31:0] e0;
  input [31:0] x;
  begin
    e0 = {x[1:0],x[31:2]} ^ {x[12:0],x[31:13]} ^ {x[21:0],x[31:22]};
  end
endfunction

////////////////////////////////////////////////////////////////////////////////
function [31:0] e1;
  input [31:0] x;
  begin
    e1 = {x[5:0],x[31:6]} ^ {x[10:0],x[31:11]} ^ {x[24:0],x[31:25]};
  end
endfunction

////////////////////////////////////////////////////////////////////////////////
function [31:0] s0;
  input [31:0] x;
  begin
    s0 = {x[6:4] ^ x[17:15],  {x[3:0], x[31:7]} ^ {x[14:0],x[31:18]} ^ x[31:3]};
  end
endfunction

////////////////////////////////////////////////////////////////////////////////
function [31:0] s1;
  input [31:0] x;
  begin
    s1 = {x[16:7] ^ x[18:9],  {x[6:0],x[31:17]} ^ {x[8:0],x[31:19]} ^ x[31:10]};
  end
endfunction


////////////////////////////////////////////////////////////////////////////////
function [31:0] kst1;
  input [5:0] x; // 2^6=64
  begin
    case(x)
      6'd00: kst1 = 32'h428a2f98; // index  0
      6'd01: kst1 = 32'h71374491; // index  1
      6'd02: kst1 = 32'hb5c0fbcf; // index  2
      6'd03: kst1 = 32'he9b5dba5; // index  3
      6'd04: kst1 = 32'h3956c25b; // index  4
      6'd05: kst1 = 32'h59f111f1; // index  5
      6'd06: kst1 = 32'h923f82a4; // index  6
      6'd07: kst1 = 32'hab1c5ed5; // index  7
      6'd08: kst1 = 32'hd807aa98; // index  8
      6'd09: kst1 = 32'h12835b01; // index  9
      6'd10: kst1 = 32'h243185be; // index 10
      6'd11: kst1 = 32'h550c7dc3; // index 11
      6'd12: kst1 = 32'h72be5d74; // index 12
      6'd13: kst1 = 32'h80deb1fe; // index 13
      6'd14: kst1 = 32'h9bdc06a7; // index 14
      6'd15: kst1 = 32'hc19bf174; // index 15
      6'd16: kst1 = 32'he49b69c1; // index 16
      6'd17: kst1 = 32'hefbe4786; // index 17
      6'd18: kst1 = 32'h0fc19dc6; // index 18
      6'd19: kst1 = 32'h240ca1cc; // index 19
      6'd20: kst1 = 32'h2de92c6f; // index 20
      6'd21: kst1 = 32'h4a7484aa; // index 21
      6'd22: kst1 = 32'h5cb0a9dc; // index 22
      6'd23: kst1 = 32'h76f988da; // index 23
      6'd24: kst1 = 32'h983e5152; // index 24
      6'd25: kst1 = 32'ha831c66d; // index 25
      6'd26: kst1 = 32'hb00327c8; // index 26
      6'd27: kst1 = 32'hbf597fc7; // index 27
      6'd28: kst1 = 32'hc6e00bf3; // index 28
      6'd29: kst1 = 32'hd5a79147; // index 29
      6'd30: kst1 = 32'h06ca6351; // index 30
      6'd31: kst1 = 32'h14292967; // index 31
      6'd32: kst1 = 32'h27b70a85; // index 32
      6'd33: kst1 = 32'h2e1b2138; // index 33
      6'd34: kst1 = 32'h4d2c6dfc; // index 34
      6'd35: kst1 = 32'h53380d13; // index 35
      6'd36: kst1 = 32'h650a7354; // index 36
      6'd37: kst1 = 32'h766a0abb; // index 37
      6'd38: kst1 = 32'h81c2c92e; // index 38
      6'd39: kst1 = 32'h92722c85; // index 39
      6'd40: kst1 = 32'ha2bfe8a1; // index 40
      6'd41: kst1 = 32'ha81a664b; // index 41
      6'd42: kst1 = 32'hc24b8b70; // index 42
      6'd43: kst1 = 32'hc76c51a3; // index 43
      6'd44: kst1 = 32'hd192e819; // index 44
      6'd45: kst1 = 32'hd6990624; // index 45
      6'd46: kst1 = 32'hf40e3585; // index 46
      6'd47: kst1 = 32'h106aa070; // index 47
      6'd48: kst1 = 32'h19a4c116; // index 48
      6'd49: kst1 = 32'h1e376c08; // index 49
      6'd50: kst1 = 32'h2748774c; // index 50
      6'd51: kst1 = 32'h34b0bcb5; // index 51
      6'd52: kst1 = 32'h391c0cb3; // index 52
      6'd53: kst1 = 32'h4ed8aa4a; // index 53
      6'd54: kst1 = 32'h5b9cca4f; // index 54
      6'd55: kst1 = 32'h682e6ff3; // index 55
      6'd56: kst1 = 32'h748f82ee; // index 56
      6'd57: kst1 = 32'h78a5636f; // index 57
      6'd58: kst1 = 32'h84c87814; // index 58
      6'd59: kst1 = 32'h8cc70208; // index 59
      6'd60: kst1 = 32'h90befffa; // index 60
      6'd61: kst1 = 32'ha4506ceb; // index 61
      6'd62: kst1 = 32'hbef9a3f7; // index 62
      6'd63: kst1 = 32'hc67178f2; // index 63
      default: kst1 = {32{1'bX}};
    endcase
  end
endfunction


////////////////////////////////////////////////////////////////////////////////
function [31:0] kst2;
  input [6:0] x; // 2^7=128
  begin
    case(x)
      7'd0: kst2 = 32'h90befffa; // index 60
      //7'd1: kst2 = 32'ha4506ceb; // index 61
      //7'd2: kst2 = 32'hbef9a3f7; // index 62
      //7'd3: kst2 = 32'hc67178f2; // index 63
      7'd00+5: kst2 = 32'h428a2f98; // index  0
      7'd01+5: kst2 = 32'h71374491; // index  1
      7'd02+5: kst2 = 32'hb5c0fbcf; // index  2
      7'd03+5: kst2 = 32'he9b5dba5; // index  3
      7'd04+5: kst2 = 32'h3956c25b; // index  4
      7'd05+5: kst2 = 32'h59f111f1; // index  5
      7'd06+5: kst2 = 32'h923f82a4; // index  6
      7'd07+5: kst2 = 32'hab1c5ed5; // index  7
      7'd08+5: kst2 = 32'hd807aa98;
      7'd09+5: kst2 = 32'h12835b01;
      7'd10+5: kst2 = 32'h243185be;
      7'd11+5: kst2 = 32'h550c7dc3;
      7'd12+5: kst2 = 32'h72be5d74;
      7'd13+5: kst2 = 32'h80deb1fe;
      7'd14+5: kst2 = 32'h9bdc06a7;
      7'd15+5: kst2 = 32'hc19bf174;
      7'd16+5: kst2 = 32'he49b69c1;
      7'd17+5: kst2 = 32'hefbe4786;
      7'd18+5: kst2 = 32'h0fc19dc6;
      7'd19+5: kst2 = 32'h240ca1cc;
      7'd20+5: kst2 = 32'h2de92c6f;
      7'd21+5: kst2 = 32'h4a7484aa;
      7'd22+5: kst2 = 32'h5cb0a9dc;
      7'd23+5: kst2 = 32'h76f988da;
      7'd24+5: kst2 = 32'h983e5152;
      7'd25+5: kst2 = 32'ha831c66d;
      7'd26+5: kst2 = 32'hb00327c8;
      7'd27+5: kst2 = 32'hbf597fc7;
      7'd28+5: kst2 = 32'hc6e00bf3;
      7'd29+5: kst2 = 32'hd5a79147;
      7'd30+5: kst2 = 32'h06ca6351;
      7'd31+5: kst2 = 32'h14292967;
      7'd32+5: kst2 = 32'h27b70a85;
      7'd33+5: kst2 = 32'h2e1b2138;
      7'd34+5: kst2 = 32'h4d2c6dfc;
      7'd35+5: kst2 = 32'h53380d13;
      7'd36+5: kst2 = 32'h650a7354;
      7'd37+5: kst2 = 32'h766a0abb;
      7'd38+5: kst2 = 32'h81c2c92e;
      7'd39+5: kst2 = 32'h92722c85;
      7'd40+5: kst2 = 32'ha2bfe8a1;
      7'd41+5: kst2 = 32'ha81a664b;
      7'd42+5: kst2 = 32'hc24b8b70;
      7'd43+5: kst2 = 32'hc76c51a3;
      7'd44+5: kst2 = 32'hd192e819;
      7'd45+5: kst2 = 32'hd6990624;
      7'd46+5: kst2 = 32'hf40e3585;
      7'd47+5: kst2 = 32'h106aa070;
      7'd48+5: kst2 = 32'h19a4c116;
      7'd49+5: kst2 = 32'h1e376c08;
      7'd50+5: kst2 = 32'h2748774c;
      7'd51+5: kst2 = 32'h34b0bcb5;
      7'd52+5: kst2 = 32'h391c0cb3;
      7'd53+5: kst2 = 32'h4ed8aa4a;
      7'd54+5: kst2 = 32'h5b9cca4f;
      7'd55+5: kst2 = 32'h682e6ff3;
      7'd56+5: kst2 = 32'h748f82ee;
      7'd57+5: kst2 = 32'h78a5636f;
      7'd58+5: kst2 = 32'h84c87814;
      7'd59+5: kst2 = 32'h8cc70208; // index 59
/*    7'd60+5: kst2 = 32'h90befffa;
      7'd61+5: kst2 = 32'ha4506ceb;
      7'd62+5: kst2 = 32'hbef9a3f7;
      7'd63+5: kst2 = 32'hc67178f2;
*/
      default: kst2 = {32{1'bX}};
    endcase
  end
endfunction


////////////////////////////////////////////////////////////////////////////////
function [31:0] ki;
  input [5:0] x; // 2^6=64
  begin
    case(x)
      6'd00: ki = 32'h428a2f98; // index  0
      6'd01: ki = 32'h71374491; // index  1
      6'd02: ki = 32'hb5c0fbcf; // index  2
      6'd03: ki = 32'he9b5dba5; // index  3
      6'd04: ki = 32'h3956c25b; // index  4
      6'd05: ki = 32'h59f111f1; // index  5
      6'd06: ki = 32'h923f82a4; // index  6
      6'd07: ki = 32'hab1c5ed5; // index  7
      6'd08: ki = 32'hd807aa98; // index  8
      6'd09: ki = 32'h12835b01; // index  9
      6'd10: ki = 32'h243185be; // index 10
      6'd11: ki = 32'h550c7dc3; // index 11
      6'd12: ki = 32'h72be5d74; // index 12
      6'd13: ki = 32'h80deb1fe; // index 13
      6'd14: ki = 32'h9bdc06a7; // index 14
      6'd15: ki = 32'hc19bf174; // index 15
      6'd16: ki = 32'he49b69c1; // index 16
      6'd17: ki = 32'hefbe4786; // index 17
      6'd18: ki = 32'h0fc19dc6; // index 18
      6'd19: ki = 32'h240ca1cc; // index 19
      6'd20: ki = 32'h2de92c6f; // index 20
      6'd21: ki = 32'h4a7484aa; // index 21
      6'd22: ki = 32'h5cb0a9dc; // index 22
      6'd23: ki = 32'h76f988da; // index 23
      6'd24: ki = 32'h983e5152; // index 24
      6'd25: ki = 32'ha831c66d; // index 25
      6'd26: ki = 32'hb00327c8; // index 26
      6'd27: ki = 32'hbf597fc7; // index 27
      6'd28: ki = 32'hc6e00bf3; // index 28
      6'd29: ki = 32'hd5a79147; // index 29
      6'd30: ki = 32'h06ca6351; // index 30
      6'd31: ki = 32'h14292967; // index 31
      6'd32: ki = 32'h27b70a85; // index 32
      6'd33: ki = 32'h2e1b2138; // index 33
      6'd34: ki = 32'h4d2c6dfc; // index 34
      6'd35: ki = 32'h53380d13; // index 35
      6'd36: ki = 32'h650a7354; // index 36
      6'd37: ki = 32'h766a0abb; // index 37
      6'd38: ki = 32'h81c2c92e; // index 38
      6'd39: ki = 32'h92722c85; // index 39
      6'd40: ki = 32'ha2bfe8a1; // index 40
      6'd41: ki = 32'ha81a664b; // index 41
      6'd42: ki = 32'hc24b8b70; // index 42
      6'd43: ki = 32'hc76c51a3; // index 43
      6'd44: ki = 32'hd192e819; // index 44
      6'd45: ki = 32'hd6990624; // index 45
      6'd46: ki = 32'hf40e3585; // index 46
      6'd47: ki = 32'h106aa070; // index 47
      6'd48: ki = 32'h19a4c116; // index 48
      6'd49: ki = 32'h1e376c08; // index 49
      6'd50: ki = 32'h2748774c; // index 50
      6'd51: ki = 32'h34b0bcb5; // index 51
      6'd52: ki = 32'h391c0cb3; // index 52
      6'd53: ki = 32'h4ed8aa4a; // index 53
      6'd54: ki = 32'h5b9cca4f; // index 54
      6'd55: ki = 32'h682e6ff3; // index 55
      6'd56: ki = 32'h748f82ee; // index 56
      6'd57: ki = 32'h78a5636f; // index 57
      6'd58: ki = 32'h84c87814; // index 58
      6'd59: ki = 32'h8cc70208; // index 59
      6'd60: ki = 32'h90befffa; // index 60
      6'd61: ki = 32'ha4506ceb; // index 61
      6'd62: ki = 32'hbef9a3f7; // index 62
      6'd63: ki = 32'hc67178f2; // index 63
      default: ki = {32{1'bX}};
    endcase
  end
endfunction

//EOF
