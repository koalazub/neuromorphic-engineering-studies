`timescale 1ns / 1ps

module TM_LIF_tb ();

  parameter CLK_PD = 10;

  reg         clk_in;
  reg         reset_n;
  reg  [ 8:0] leak_rate;
  reg  [ 8:0] charge_rate;
  reg  [ 8:0] Vrst;
  reg  [ 9:0] Vth;
  reg  [ 9:0] syn_to_LIF;
  reg  [19:0] LFSR_gen;
  wire        LIF_spike;

  initial begin
    clk_in = 1;
    reset_n = 1;
    leak_rate = 465;  //10ms
    charge_rate = 465;  //1ms
    Vrst = 9'd500;
    Vth = 10'd512;
    //syn_to_LIF = 13'd1234;
    #2 reset_n = 0;
    #1000 reset_n = 1;
  end

  always @(*) begin
    syn_to_LIF[9:0] = LFSR_gen[9:0];
  end

  always @(posedge clk_in or negedge reset_n) begin
    if (!reset_n) LFSR_gen <= #1 20'd8964;
    else LFSR_gen <= #1{LFSR_gen[18:3], LFSR_gen[2] ^ LFSR_gen[19], LFSR_gen[1:0], LFSR_gen[19]};
  end

  always begin
    #CLK_PD clk_in = ~clk_in;
  end

  TM_LIF U_TM_LIF (
      //# .reset_n(reset_n),
      .clk_in(clk_in),
      .LIF_spike(LIF_spike),
      .leak_rate(leak_rate),
      .charge_rate(charge_rate),
      .Vrst(Vrst),
      .Vth(Vth),
      .syn_i(syn_to_LIF)
  );

  initial begin
    // Dump waveform to a VCD file for later inspection if needed.
    $dumpfile("simulation.vcd");
    $dumpvars(0, TM_LIF_tb);

    // Wait for a defined simulation period then finish.
    #20000;
    $finish;
  end

endmodule

