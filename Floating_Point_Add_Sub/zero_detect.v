`timescale 1ns / 1ps

//Module: see if the result of the operation results in a zero

module zero_detect(
sign_A, sign_B, funct, exp_diff, mant_diff, zero
    );

input sign_A, sign_B, funct; //sign bits of A and B, and function being performed
input [3:0] exp_diff; //exponential difference (exp_A - exp_B)
input [4:0] mant_diff; //mantissa difference (mant_A - mant_B)
output zero; //assert true when result is zero


reg zero; //Internal Variable //

always@(*)
begin

//(sign_A^sign_B)^funct is 1 when after you convert the operation to addition
//(i.e. a - b => a + (-b) OR a - (-b) => a + b) if the signs of A and B are different
// then only sign bit can become zero
// we know that "XOR" is an inequality detector 

if(((sign_A^sign_B)^funct)&(exp_diff == 4'b0000)&(mant_diff == 5'b00000))
begin
zero <= 1; 
end

//zero asserted if the signs of A and B are
//different and there is no
//difference in the mantissa and exponent
// a number plus a conjugate

else
begin
zero <= 0;
end


end
endmodule
