module updown_tb;
  reg clk;
  reg state;
  wire [1:0] toggle;

  up_down uut (
    .clk(clk),
    .state(state),
    .toggle(toggle)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
  end

  initial begin
    $dumpfile("up_down_testbench.vcd");
    $dumpvars(0, up_down_tb);

    state = 0;  
    #30;
    
    state = 1;  
    #100;       
    
    state = 0;  
    #30;
    
    state = 1;  
    #100;
    
    $finish;
  end

  initial
    $monitor("Time = %0t, State = %b, Toggle = %b", $time, state, toggle);

endmodule
