`timescale 1ns / 1ps

module tb;

	// Inputs
	reg [7:0] A;
	reg [7:0] B;
	reg funct;

	// Outputs
	wire zero;
	wire [7:0] Y;

	// Instantiate the Unit Under Test (UUT)
	topadder uut (
		.A(A), 
		.B(B), 
		.funct(funct), 
		.zero(zero), 
		.Y(Y)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		funct = 0;
		#100;
		
		A = 01010100;
		B = 01010100;
		funct = 0;
		#100;
        
		  
		// Add stimulus here

	end
      
endmodule

