`timescale 1ns / 1ps

module topadder(
    input [7:0] A,		// Input number A //
    input [7:0] B,		// Input Number B //
    input funct,			// Value = 0 means 'ADD' , Value = 1 means 'SUB' // 
    output zero,			// Zero Flag , value = 1, if answer is zero... else value = 0 // 
    output [7:0] Y		// Output .. our needed answer //
    );
	
/************************* Internal Variables *************************/

wire [2:0] exp_A;
wire [2:0] exp_B;			// Variables to store exponent parts //
wire [2:0] exp_Y;

wire sign_Y; 				// Variable that tells us the sign bit of Y //

wire [3:0] mant_Y;		// Variable that stores the mantissa of output //


wire [2:0] exp_diff_norm; 
/* 
The above two are used in normalization module...
Used to shift mantissa, till exponents become equal 
*/

wire [1:0] exp_diff_sign; 
/*
Stores  the sign of ( exp_a - exp_b ) 
tells the normalization module,
 whether to increase the exponent or decrease it.
Accordingly shift mantissa part to right or left
*/

wire [3:0] exp_diff; // Stores the result of exp_A - exp_B//

/****************************End of Internal Variables ***********************/



/******************************** Code begins here ****************************/


/*For an 8-bit data,
 The MSB gives the sign 
 Next 3 bits tell the exponent
 The last 4-bits show the mantissa */
 
assign exp_A = A[6:4]; 
assign exp_B = B[6:4];

assign Y = {sign_Y, exp_Y, mant_Y}; //Initial value of output Y //


//module call to the synthesized mantissa datapath //
synth_part get_mant(A, B, funct, zero, exp_diff_norm, exp_diff_sign, exp_diff, sign_Y,
mant_Y);

//module call to the exponent datapath //
exp_part get_exp(exp_A, exp_B, exp_diff_norm, exp_diff_sign, exp_diff, exp_Y);


endmodule

