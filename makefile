all: ALUcontrol.t math.t alu.t multiplexer.t 32bitGates.t
	iverilog -o ALUcontrol.t ALUcontrol.t.v
	iverilog -o math.t math.t.v
	iverilog -o alu.t alu.t.v
	iverilog -o multiplexer.t multiplexer.t.v
	iverilog -o 32bitGates.t 32bitGates.t.v