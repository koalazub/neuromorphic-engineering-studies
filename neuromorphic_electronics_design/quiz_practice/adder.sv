module adder (
    input wire [3:0] x,
    input wire [3:0] y,

    output wire [3:0] result
);

  assign result = x + y;

endmodule

module top (
    input  wire [3:0] x,
    input  wire [3:0] y,
    output wire [3:0] result1,
    output wire [3:0] result2
);

  adder calculate (
      .x(x),
      .y(y),
      .result(result1)
  );


  wire [3:0] x_times_2;
  wire [3:0] y_div_2;

  assign x_times_2 = {x[2:0], 1'b0};  // x * 2 shift left
  assign y_div_2   = {1'b0, y[3:1]};  // y / 2 shift right

  adder new_calculation (
      .x(x_times_2),
      .y(y_div_2),
      .result(result2)
  );

endmodule
