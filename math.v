// Adder circuit

`define AND and #20
`define OR or #20
`define NOT not #10
`define XOR xor #30

module structuralFullAdder
(
    output sum, 
    output carryout,
    input a, 
    input b, 
    input carryin
);
    wire AandB, AandC, BandC;

    // sum is 1 when either one of the inputs is 1 or all of them are 1
    `XOR xorGate(sum, a, b, carryin);

    `AND andGate0(AandB, a, b);
    `AND andGate1(AandC, a, carryin);
    `AND andGate2(BandC, b, carryin);

    // carryout = (AB)+(BC)+(AC)
    `OR orGate(carryout, AandB, AandC, BandC);

endmodule

module CompAdder4bit
(
  output[3:0] sum,  // 2's complement sum of a and b
  output carryout,  // Carry out of the summation of a and b
  //output overflow,
  input[3:0] a,     // First operand in 2's complement format
  input[3:0] b,      // Second operand in 2's complement format
  input carryin
);

    wire temp_cout[2:0];

    structuralFullAdder fa0(sum[0], temp_cout[0], a[0], b[0], 0);
    structuralFullAdder fa1(sum[1], temp_cout[1], a[1], b[1], temp_cout[0]);
    structuralFullAdder fa2(sum[2], temp_cout[2], a[2], b[2], temp_cout[1]);
    structuralFullAdder fa3(sum[3], carryout, a[3], b[3], temp_cout[2]);
    //`XOR xorGate(overflow, carryout, temp_cout[2]);
endmodule

module FullAdder32bit
(
    output[31:0] sum,
    output carryout,
    output overflow,
    input[31:0] a,
    input[31:0] b
    );
        wire temp_cout[6:0];

        CompAdder4bit f40(sum[3:0], temp_cout[0], a[3:0], b[3:0], 0); 
        CompAdder4bit f41(sum[7:4], temp_cout[1], a[7:4], b[7:4], temp_cout[0]);
        CompAdder4bit f42(sum[11:8], temp_cout[2], a[11:8], b[11:8], temp_cout[1]);
        CompAdder4bit f43(sum[15:12], temp_cout[3], a[15:12], b[15:12], temp_cout[2]);
        CompAdder4bit f44(sum[19:16], temp_cout[4], a[19:16], b[19:16], temp_cout[3]); 
        CompAdder4bit f45(sum[23:20], temp_cout[5], a[23:20], b[23:20], temp_cout[4]);
        CompAdder4bit f46(sum[27:24], temp_cout[6], a[27:24], b[27:24], temp_cout[5]);
        CompAdder4bit f47(sum[31:28], carryout, a[31:28], b[31:28], temp_cout[6]);
        `XOR xorGate(overflow, carryout, temp_cout[6]);
endmodule