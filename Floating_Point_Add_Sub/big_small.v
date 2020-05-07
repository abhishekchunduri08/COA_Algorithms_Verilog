`timescale 1ns / 1ps

//Module: find which mantissa is bigger

module big_small (


input [3:0] mant_A,
input [3:0] mant_B,
input [3:0] exp_diff,
input exp_diffsig,
input mant_diffsig,
output reg [3:0] big_mant,
output reg [3:0] small_mant
);




always@(*)

//if there exponents are equal
if (exp_diff == 4'b0000)
begin
big_mant <= (mant_diffsig)? mant_B: mant_A;
//assign based on which mantissa value is larger
small_mant <= (mant_diffsig)? mant_A: mant_B;
end


//if the exponents are not equal
else
begin
big_mant <= (exp_diffsig)? mant_B: mant_A;
//big mant is the mantissa of the number with the larger exponent
small_mant <= (exp_diffsig)? mant_A: mant_B;
end
//small mant is the other mantissa



endmodule
