`timescale 1ns / 1ps

// This module will be checking the Q_i-1 bit and Q_i bit and take decision //

// If Q_i-1 bit to Q_i transistion is 0->1 , then A-M , followed by right shift //
// If Q_i-1 bit to Q_i transistion is 1->0 , then A+M, followed by right shift //
// If Q_i-1 bit to Q_i transistion is 0->0 or 1->1 , then do only the right shift //


module booths_multiplier_block(
    input [3:0] A_in,
    input [3:0] M,
    input [4:0] Q_in,
    output [3:0] A_out,
    output [4:0] Q_out
    );

// A ---> Accumilator , Q ---> Multiplier , M ---> Multiplicand .... //
// output is the registers A and Q taken together in respective order //

// Note that our Q_out register is of 5 bits and not 4 bits, since it has the additional Q_i-1 bit //
// the last two bits in Q register are our Q_i-1 and Q_i bits // 
  



// Temporary Registers //

reg [3:0] A_temp;
reg [4:0] Q_temp;

wire [3:0] A_sum = A_in + M ;
wire [3:0] A_sub = A_in + ~M + 1 ;  // subtracation is same as adding 2's complement = 1's complement + 1 //



always@(A_in,M,Q_in,A_sum,A_sub) begin 


	case(Q_in[1:0])  // the last two bits in Q register are our Q_i-1 and Q_i bits // 
		
			2'b00,2'b11 :	begin
								A_temp = {A_in[3],A_in[3:1]};
								Q_temp = {A_in[0],Q_in[4:1]};         //  Right Shift Algorithm //
								end
						
			2'b01 :			begin
								A_temp = {A_sum[3],A_sum[3:1]};
								Q_temp = {A_sum[0],Q_in[4:1]};         // A+M and Right Shift Algorithm//
								end
				
				
			2'b10 :			begin
								A_temp = {A_sub[3],A_sub[3:1]};
								Q_temp = {A_sub[0],Q_in[4:1]};         // A-M and Right Shift Algorithm//
								end
									
	endcase
end


assign A_out = A_temp;
assign Q_out = Q_temp;


endmodule
