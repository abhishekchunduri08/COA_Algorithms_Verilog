`timescale 1ns / 1ps

//Module: Verilog representation of the exponent datapath



module exp_part(exp_A, exp_B, exp_diff_norm, exp_diff_sign, exp_diff, exp_Y);


input [2:0] exp_A, exp_B, exp_diff_norm; //exponent values of A, B and the normalization number

input [1:0]exp_diff_sign; //operation in order to normalize

output [3:0] exp_diff; //the difference between exp_A - exp_B

output [2:0] exp_Y; //final exponent value

wire exp_diffsig; //0 => exp_A is greater than or equal to exp_B
						// 1 => exp_A is less than exp_B

wire [2:0] temp_exp_Y; //holds the larger exponent value
reg [2:0] exp_Y;


assign exp_diff = exp_A - exp_B; 	//find the exponent difference
assign exp_diffsig = exp_diff[3];	//give temp_exp_Y the exp value of the bigger exp value

assign temp_exp_Y = (exp_diffsig)? exp_B: exp_A;	//normalizing the exponent value


always@(exp_diff_norm or exp_diff_sign or temp_exp_Y)

		if(exp_diff_sign[1]) //if =1 subtract
				exp_Y <= (temp_exp_Y) - (exp_diff_norm);
		else
						//if =0 add
				exp_Y <= (temp_exp_Y) + (exp_diff_norm);

endmodule

