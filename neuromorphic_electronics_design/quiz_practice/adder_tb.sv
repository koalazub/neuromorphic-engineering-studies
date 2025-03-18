module adder_tb;

  reg [3:0] x, y;
  wire [3:0] result;

  adder dut (
      .x(x),
      .y(y),
      .result(result)
  );

  initial begin
    $monitor("Time= %t | x = %b y = %b result = %b", $time, x, y, result);


    x = 4'b0001;
    y = 4'b0010;
    #10;
    x = 4'b0101;
    y = 4'b0011;
    #10;
    x = 4'b1111;
    y = 4'b0001;
    #10;

    $finish;
  end

endmodule
