`timescale 1ns / 1ps

//Module: Determines the sign of the resulting value


module final_sign (exp_diffsig, mant_diffsig, exp_diff, sign_A, sign_B, sign_Y);

input exp_diffsig; // 0 => exp_A is greater than or equal to exp_B
						// 1 => exp_A is less than exp_B
						
input mant_diffsig; // 0 => mant_A is greater than or equal to mant_B
							// 1 => mant_A is less than mant_B
							
							
input [3:0]exp_diff; //the exponent difference (exp_A - exp_B)

input sign_A; //sign bits of A, B, and Y

input sign_B;
output sign_Y;
reg sign_Y;


always@(exp_diffsig or mant_diffsig or exp_diff or sign_B or sign_A)
begin
		if (exp_diffsig)
			begin
			sign_Y <= sign_B; //if the exp_diffsig is 1 (number B is bigger)
			end						//give sign_Y the sign of B
		
		else
			begin
					if (exp_diff == 4'b0000) //if the exp_diff is 0 (the two exp are
													//equal), check the mantissa values
					begin
									if (mant_diffsig) //if the mant_diffsig is 1 (number B is//bigger)
										sign_Y <=sign_B; //give sign_Y the sign //of B
									else
										sign_Y <= sign_A; //if the exp_diff is 0 and the
																//mant_diffsig != 1
																
					end 						//A and B have the same exponent but the
												//difference in the mantissas are zero or
												//greater
		else 
		begin
		sign_Y <= sign_A; 		//give sign_Y the sign of A
		end 							//give sign_Y the sign of A
										//if exp_diffsig != 1
										//(exp_A is bigger) and exp_diff is greater
										//than zero

end
end
endmodule