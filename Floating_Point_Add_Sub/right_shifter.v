`timescale 1ns / 1ps

//Module: Shifts a given numner to the right by an amount (shift_amt)

module right_shifter(
    input [3:0] small_mant,
    input [2:0] shift_amt,
    output reg [5:0] shifted_mant
);


always@(small_mant or shift_amt)
case (shift_amt)
3'b000: shifted_mant <= {2'b01, small_mant[3:0]};
3'b001: shifted_mant <= {3'b001, small_mant[3:1]};
3'b010: shifted_mant <= {4'b0001, small_mant[3:2]};
3'b011: shifted_mant <= {5'b00001, small_mant[3]};
3'b100: shifted_mant <= 6'b000001;
default: shifted_mant <= 6'b000000;
endcase

endmodule