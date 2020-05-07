`timescale 1ns / 1ps

// 4-bit Booth's Multiplier//
// 3 bits is the data and the MSB is the Sign bit //
// M and Q can lie in between [-8 to +7] //

module Booths_multiplier_top_module(
    input [3:0] M,
    input [4:0] Q,
    output [7:0] Z
    );


wire [3:0] A_out1;
wire [4:0] Q_out1;

wire [3:0] A_out2;
wire [4:0] Q_out2;

wire [3:0] A_out3;
wire [4:0] Q_out3;

wire [3:0] A_out4;
wire [4:0] Q_out4;

reg [7:0] Z_temp;



//Accumilator is initially with '0000' //
// Here we make Q as 4 bit register, but in top module it's 5 bits .... so we seperately instantiate the Q_i-1 bit as '0' //


booths_multiplier_block booth1 (
	
	.A_in(4'b0000),
	.M(M),
	.Q_in({Q,1'b0}),
	.A_out(A_out1),
	.Q_out(Q_out1)
);


booths_multiplier_block booth2 (
	
	.A_in(A_out1),
	.M(M),
	.Q_in(Q_out1),
	.A_out(A_out2),
	.Q_out(Q_out2)
);


booths_multiplier_block booth3 (
	
	.A_in(A_out2),
	.M(M),
	.Q_in(Q_out2),
	.A_out(A_out3),
	.Q_out(Q_out3)
);

booths_multiplier_block booth4 (
	
	.A_in(A_out3),
	.M(M),
	.Q_in(Q_out3),
	.A_out(A_out4),
	.Q_out(Q_out4)
);


assign Z = {A_out4,Q_out4[4:1]} ;


endmodule
