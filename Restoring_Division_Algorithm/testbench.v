`timescale 1ns / 1ps



module testbench;

	// Inputs
	reg [7:0] Q;
	reg [7:0] M;

	// Outputs
	wire [7:0] Quo;
	wire [7:0] Rem;

	// Instantiate the Unit Under Test (UUT)
	restoring_divider uut (
		.Q(Q), 
		.M(M), 
		.Quo(Quo), 
		.Rem(Rem)
	);

	initial begin
		// Initialize Inputs
		Q = 9;
		M = 4;
		#100;
		
		Q = -9;
		M = 4;
		#100;
		
		Q = 9;
		M = -4;
		#100;
		
		Q = -9;
		M = -4;
		#100;
		
		
		

 
		

	end
      
endmodule

