`timescale 1ns / 1ps


module testbench;

	// Inputs
	reg [3:0] M;
	reg [3:0] Q;

	// Outputs
	wire [7:0] Z;

	// Instantiate the Unit Under Test (UUT)
	Booths_multiplier_top_module uut (
		.M(M), 
		.Q(Q), 
		.Z(Z)
	);

	initial begin
		// Initialize Inputs
		M = 0; Q = 0;
		#100 M = 4; Q = 3;
		#100 M = 7 ; Q = 2;
		#100 M = 6; Q = 5;
      #100 M = - 7; Q = 4;
		#100 M = 5; Q = -8;
		#100 M = -6; Q = -7;
		#100 M = 7; Q = -8;



	end
      
endmodule

