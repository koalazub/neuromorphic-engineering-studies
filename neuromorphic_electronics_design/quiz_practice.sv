// Quiz Question:
// Write a simple module named adder that takes two 4-bit inputs (a, b)
// and outputs their 4-bit sum (sum).

// logic is a general purpose type for signals
// we can use logic instead of wire/reg in system verilog

// reg can store values in procedural blocks
// wire represents connections between hardware elements but doesn't store values
module adder (
    input  logic [3:0] a,
    input  logic [3:0] b,
    output logic [3:0] sum  // this is 4-bit
);
  assign sum = a + b;

endmodule

initial begin
  counter = 0;
end

always @(posedge clk) begin
  counter <= counter + 1;  // so run at every clock cycle
end
