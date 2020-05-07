`timescale 1ns / 1ps

module restoring_divider(Q,M,Quo,Rem);

/* 8-bit Divider , both Q and M can be max 8-bits each */


input [7:0] Q;  //Dividend//
input [7:0] M; //Divisor//

output [7:0] Quo; 
output [7:0] Rem; 

// Internal Variables //

reg [7:0] Quo = 0;
reg [7:0] Rem = 0;
reg [7:0] Q_temp=0;
reg [7:0] M_temp = 0; // Loop Variables //
reg [7:0] Acc = 0;		// Accumilator 'A' //

	integer i;			// Keeps track of how many times loop must run //
	
	always@(*)
		begin
				
			//Initialize the Registers //
			
			Q_temp=Q;
			M_temp=M;
			Acc=0;   //Initialize Accumilator with zero //
			
			
//*****************Converting Dividend and Divisors into positive numbers if they are negative ****************** //			
			
			if (Q_temp[7]==1) begin //i.e Q is negative //
			Q_temp = 0-Q_temp;		// Now Q is positive //
			end
			
			if(M_temp[7] == 1) begin
			M_temp = 0-M_temp;
			end
			
			if ((M_temp[7]==1) && (Q_temp[7]==1)) begin
			Q_temp = 0-Q_temp;
			M_temp = 0-M_temp;
			end 
			
//***************************************** Algorithm Block ***************************************************//				
					for(i=0;i<8 ;i=i+1) begin 
					 
					 Acc = {Acc[6:0],Q_temp[7]} ; //Left shift of A//
					 Q_temp[7:1] = Q_temp[6:0] ;		//Left Shift of Q //
					 Acc = Acc - M_temp ; // A = A-M //
					 
							
							if (Acc[7] == 1) begin // Checking A < 0 or not i.e MSB = 1 //

									Q_temp[0] = 0 ; // Making Q0 = 0 if step was unsuccessful //
									
									Acc = Acc + M_temp ;// A=A+M //
									
									end
							else 
									begin
									Q_temp[0] = 1 ;// Making Q0 = 1 is step was successful //
							end
					end
//*********************** Adjust signs of Quotient and Reminder According to Q and M **********************//	

/* LOGIC USED 
				Q>0 AND M>0 ---> THEN QUOTIENT >0 AND REMINDER >0
				Q<0 AND M>0 ---> THEN QUOTIENT <0 AND REMINDER <0
				Q>0 AND M<0 ---> THEN QUOTIENT <0 AND REMINDER >0
				Q<0 AND M<0 ---> THEN QUOTIENT >0 AND REMINDER <0
***********************************************************************/				
				
				
	if((Q[7]==1) && (M[7] ==0))
	begin 
	assign Quo = 0-Q_temp;
	assign Rem = 0-Acc;
	end

	else if((Q[7]==0) && (M[7] ==1))
	begin 
	assign Quo = 0-Q_temp;
	assign Rem = Acc;
	end

	else if((Q[7]==1) && (M[7] ==1))
	begin 
	assign Quo = Q_temp;
	assign Rem = 0-Acc;
	end

	
	else 
	begin 
	assign Quo = Q_temp;
	assign Rem = Acc;
	end

end
endmodule
