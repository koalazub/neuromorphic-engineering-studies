module counter_tb;
  reg clk;
  reg reset;
  wire [3:0] count;

  counter uut (
      .clk  (clk),
      .reset(reset),
      .count(count)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Toggle every 5 time units
  end

  initial begin
    $dumpfile("counter_tb.vcd");
    $dumpvars(0, counter_tb);

    reset = 1;
    #15;
    reset = 0;

    #100;

    $finish;
  end

  initial $monitor("Time = %0t, Reset = %b, Count = %b", $time, reset, count);
endmodule
