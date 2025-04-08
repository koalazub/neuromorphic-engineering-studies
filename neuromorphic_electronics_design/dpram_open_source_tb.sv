`timescale 1ns / 1ps

module DPRAM_open_source_tb;
  ni// Signal declarations
  logic        aclr;
  logic        clock;
  logic [13:0] data;
  logic [17:0] rdaddress;
  logic [17:0] wraddress;
  logic        wren;
  logic [13:0] q;
  
  // DUT instantiation
  DPRAM_open_source dut (
    .aclr(aclr),
    .clock(clock),
    .data(data),
    .rdaddress(rdaddress),
    .wraddress(wraddress),
    .wren(wren),
    .q(q)
  );
  
  initial begin
    clock = 0;
    forever #5 clock = ~clock;  // 100MHz clock
  end
  
  // VCD generation - THIS CREATES THE WAVEFORM FILE
  initial begin
    $display("[%0t] Generating VCD file for waveform viewing", $time);
    $dumpfile("dump.vcd");
    $dumpvars(0, DPRAM_open_source_tb);
  end
  
  initial begin
    aclr = 0;
    data = 0;
    rdaddress = 0;
    wraddress = 0;
    wren = 0;
    
    $display("[%0t] Applying reset", $time);
    aclr = 1;
    #10;
    aclr = 0;
    #10;
    
    $display("[%0t] Testing write operations", $time);
    for (int i = 0; i < 10; i++) begin
      @(posedge clock);
      wraddress = i;
      data = 'h1000 + i;
      wren = 1;
      @(posedge clock);
      wren = 0;
      #10;
    end
    
    // Test reading from those addresses
    $display("[%0t] Testing read operations", $time);
    for (int i = 0; i < 10; i++) begin
      @(posedge clock);
      rdaddress = i;
      @(posedge clock);  // Wait for data to appear
      @(posedge clock);  // Extra cycle to ensure data is stable
      if (q != ('h1000 + i)) begin
        $display("Error at address %0d: Expected %h, got %h", i, ('h1000 + i), q);
      end else begin
        $display("Success at address %0d: Got %h", i, q);
      end
    end
    
    // Test read-during-write (should return old data)
    $display("[%0t] Testing read-during-write", $time);
    @(posedge clock);
    rdaddress = 5;
    wraddress = 5;
    data = 'h2005;
    wren = 1;
    @(posedge clock);
    @(posedge clock);
    if (q != 'h1005) begin
      $display("Read-during-write test failed: Expected %h, got %h", 'h1005, q);
    end else begin
      $display("Read-during-write test passed: Got old data %h", q);
    end
    wren = 0;
    
    // Read the updated value
    $display("[%0t] Testing updated value read", $time);
    @(posedge clock);
    @(posedge clock);
    if (q != 'h2005) begin
      $display("Updated value test failed: Expected %h, got %h", 'h2005, q);
    end else begin
      $display("Updated value test passed: Got %h", q);
    end
    
    // Test asynchronous clear
    $display("[%0t] Testing asynchronous clear", $time);
    @(posedge clock);
    aclr = 1;
    #2;  // Mid-clock cycle
    if (q != 0) begin
      $display("Async clear test failed: Expected 0, got %h", q);
    end else begin
      $display("Async clear test passed: Got %h", q);
    end
    aclr = 0;
    
    // Finish simulation
    #100;
    $display("[%0t] Testbench completed!", $time);
    $finish;
  end
endmodule
