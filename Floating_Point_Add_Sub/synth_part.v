`timescale 1ns / 1ps


/* Module: top level module for the synthesis mantissa datapath */



module synth_part(
    input [3:0] exp_diff,
    input [7:0] A,
    input [7:0] B,
    input funct,
    output zero,
    output sign_Y,
    output [3:0] mant_Y,
    output [2:0] exp_diff_norm,
    output [1:0] exp_diff_sign
    );

/************************ Internal Variables *************************/

wire sign_A; //sign bits of A, B, and Y
wire sign_B;
wire sign_Y;

wire temp_sign; 
/*helps with temporarily holding sign_B value 
in case we need to do accommodate subtraction calls*/

wire [3:0] mant_A; //mantissa bits of A, B, and Y
wire [3:0] mant_B;
wire [3:0] mant_Y;

wire [5:0] temp_mant_Y; 
//holds the sum of the two mantissa before normalization //

wire [3:0] exp_diff; 
/* Tells the amount by which smaller exponent has to be increased, so as to make exponents equal */
/* We can also understand as the amount by which mantissa has to be shifted is determined from here*/

wire exp_diffsig; 
/* MSB in the exp_diff value,
this will check for neg. values */

wire [4:0] mant_diff; //mant_A - mant_B

wire mant_diffsig; 
//MSB of mant_diff
//A check to determine ,which mantissa value was larger.
//if the bit is 0, A is larger
//if the bit is 1, B is larger


wire [3:0] small_mant; 
//holds the mantissa of the number with the
//smaller exponent
//When exponents equal, we set this to the mantissa of A
wire [2:0] shift_amount;
//amount to shift the small_mant (equal to exp_diff)

wire [5:0] shifted_mant; 
//small mantissa shifted by shift amount

wire [3:0] big_mant; 
//mantissa of the number with the bigger exponent

wire temp_sign_B;
//holds the final value of B's sign, needed to
//help in case of subtraction

wire [5:0] twos_small_mant; 
//possible two's compliment of the shifted
//mantissa, two's compliment
//used if subtraction is used
wire [1:0] exp_diff_sign; 
//tells normalize whether to add or subtract a
//certain value in
//order to properly normalize the exponent

wire [2:0] exp_diff_norm; 
//the value to add or subtract to normalize
//the exponent
/******************************************************** CODE Begins HERE *************************************************************/

assign sign_A = A[7]; //assign the sign bit of A, B
assign sign_B = B[7];
assign mant_A = A[3:0]; //assign mantissa bits of A, B
assign mant_B = B[3:0];

assign exp_diffsig = exp_diff[3]; 
//exp_diff is an input so set the highest bit
// 1 => exp_B is larger than exp_A
// 0 => exp_A is larger than exp_B


//find mantissa difference
assign mant_diff = mant_A - mant_B;
assign mant_diffsig = mant_diff[4]; 
//mant_diff
// 1 => mant_B is larger than mant_A
// 0 => mant_A is larger than mant_B

//assign small_mant to be the value of the mantissa of the number with the smaller of the
//two exponents
big_small mants(mant_A, mant_B, exp_diff, exp_diffsig, mant_diffsig, big_mant,
small_mant);

/*
assign the shift amount, don't need the highest bit of exp_diff since it just tells you
which exponent is larger. Also, if exp_B is larger, the exp_diff is in two's compliment
form so perform another two's compliment to get a positive shift value
*/

assign shift_amount = (exp_diffsig)? -(exp_diff[2:0]): exp_diff[2:0];


//code for addition or subtraction, if subtraction is being done, swapthe sign bit of B //
assign temp_sign = funct? ~sign_B: sign_B;
assign temp_sign_B = temp_sign;
//shift mantissa to align decimal points

right_shifter shift_mantissa(small_mant, shift_amount, shifted_mant);
//calculate the two's compliment of the shifted mant, only needed in the case of
//subtraction or equivalent case (i.e. adding a negative number to a positive number)

twos_comp two_small_mant(sign_A, sign_B, funct, shifted_mant, twos_small_mant);
//add the two mantissas together
assign temp_mant_Y ={1'b1, big_mant} + twos_small_mant;

//assign zero detect
zero_detect zero_find(sign_A, sign_B, funct, exp_diff, mant_diff, zero);

//normalize the mantissa and exponent value so it's back in floating point representation
normalize normal(temp_mant_Y, mant_Y, exp_diff_norm, exp_diff_sign);

//determine sign of the final value
final_sign sign_find(exp_diffsig, mant_diffsig, exp_diff, sign_A, temp_sign_B, sign_Y);

endmodule
