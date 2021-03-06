`define NAND32 nand #10
`define NOR32  nor  #10
`define NOT32  not  #10

// NAND A and B iteritavely
module nand32 (
  output [31:0] AnandB,
  input [31:0] A,
  input [31:0] B
  );
  
  generate
  genvar index;

	for (index = 0; index<32; index = index + 1) begin : NAND
		`NAND32 nandgate(AnandB[index], A[index], B[index]);
	end
	endgenerate
endmodule

// NOR A and B iteritavely
module nor32 (
  output [31:0] AnorB,
  input [31:0] A,
  input [31:0] B
  );
  
  generate
  genvar index;

	for (index = 0; index<32; index = index + 1) begin : NOR
		`NOR32 norgate(AnorB[index], A[index], B[index]);
	end
	endgenerate
endmodule


// NOT the input iteritavely
module not32 (
  output [31:0] notA,
  input [31:0] A
  );

  genvar index;

	generate
		for (index = 0; index<32; index = index + 1) begin : NOT
			`NOT32 notgate(notA[index], A[index]);
		end
	endgenerate
endmodule


// NAND the inputs and then invert it
module and32 (
  output [31:0] AandB,
  input [31:0] A,
  input [31:0] B
  );
  
  wire [31:0] AnandB;

  generate
  genvar index;

	for (index = 0; index<32; index = index + 1) begin : NAND
		`NAND32 nandgate(AnandB[index], A[index], B[index]);
    `NOT32 notgate(AandB[index], AnandB[index]);
	end
	endgenerate
endmodule


// NOR the inputs and then invert it
module or32 (
  output [31:0] AorB,
  input [31:0] A,
  input [31:0] B
  );
  
  wire [31:0] AnorB;

  generate
  genvar index;

	for (index = 0; index<32; index = index + 1) begin : NOR
		`NOR32 norgate(AnorB[index], A[index], B[index]);
    `NOT32 notgate(AorB[index], AnorB[index]);
	end
	endgenerate
endmodule


// XORs the 2 inputs together using NOR gates
module xor32 (
  output [31:0] AxorB,
  input [31:0] A,
  input [31:0] B
  );
  
  wire [31:0] AnorA;
  wire [31:0] BnorB;
  wire [31:0] AAnorBB;
  wire [31:0] AnorB;

  generate
  genvar index;

	for (index = 0; index<32; index = index + 1) begin : XOR
		`NOR32 norgate(AnorA[index], A[index], A[index]);
    `NOR32 norgate(BnorB[index], B[index], B[index]);
    `NOR32 norgate(AAnorBB[index], AnorA[index], BnorB[index]);
    `NOR32 norgate(AnorB[index], A[index], B[index]);
    `NOR32 norgate(AxorB[index], AAnorBB[index], AnorB[index]);
	end
	endgenerate
endmodule
