`timescale 1ns / 1ps


//Module: Normalize the final exponent and mantissa value 
//so it can be represented in floating point format



module normalize(

input[5:0] in_mant, 
output reg [3:0] out_mant,
output reg [2:0]exp_diff_norm,
output reg [1:0] exp_diff_sign

);



//find the first "1" (i.e. locate a one and shift accordingly in order to get the implicite
//leading one for floating point representation

always@(in_mant)	begin
			if (in_mant[5])
						begin
							out_mant <= in_mant[4:1];
							exp_diff_norm <= 3'b001;
							exp_diff_sign <= 2'b01; //0 means add to in_exp ,the value in exp_diff_sign[1]
															//can be decoded to determine the
															//operation
															// 0 => add
															// 1 => subtract

															//the other bit is used in the exponent
															//datapath for the select_bar line of a
															//mux
						end
			else if (in_mant[4])
						begin
												out_mant <= in_mant[3:0];
												exp_diff_norm <= 3'b000;
												exp_diff_sign <=2'b01;
						end
												
			else if (in_mant[3])
						begin
												out_mant <= {in_mant[2:0], 1'b0};
												exp_diff_norm <= 3'b001; //1
												exp_diff_sign <= 2'b10; // 1 means to subtract
						end
			
			else if (in_mant[2])
						begin
												out_mant <= {in_mant[1:0], 2'b00};
												exp_diff_norm <= 3'b010; //2
												exp_diff_sign <= 2'b10; //subtract
						end
												
			else if (in_mant[1])
						begin
												out_mant <= {in_mant[0], 3'b000};
												exp_diff_norm <= 3'b011; //3
												exp_diff_sign <= 2'b10; //subtract
						end
												
			else if (in_mant[0])
						begin
												out_mant <= 4'b0000;
												exp_diff_norm <= 3'b100; //4
												exp_diff_sign <= 2'b10; //subtract
						end

			else
						begin
												out_mant <= in_mant;
												exp_diff_norm <= 3'b001; //1
												exp_diff_sign <= 2'b01; //add
						end
	end




endmodule
