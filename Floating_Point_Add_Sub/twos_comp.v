`timescale 1ns / 1ps

//Module: perform two's compliment if subtraction operation is called for

module twos_comp (sign_A, sign_B, funct, shifted_mant, twos_small_mant);

input sign_A, sign_B, funct; 
//sign bits of A and B, function being performed


input [5:0] shifted_mant; 
/*the smaller mantissa shifted so that the
numbers are aligned in order to do the
operation*/


output [5:0] twos_small_mant; 

/*result either same as input or the two'scompliment of input
two's compliment of shifted mantissa,
if numbers are being subtracted or adding a negative number*/

assign twos_small_mant = ((sign_A^sign_B)^funct)? -(shifted_mant): shifted_mant;
endmodule

