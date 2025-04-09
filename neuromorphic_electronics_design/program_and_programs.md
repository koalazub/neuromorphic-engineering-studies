Below is a list of tools that I've managed to marshal to get started with my studies doing neuromorphic electronics design.

The intent was to:

- find open source tooling that is maintained and open source
- able to be interacted with on a cross-platform basis
- easy to onboard others if they wanted to use the same tools consistently
- use tools that otherwise aren't available for MacOS

Intel Quartus is an example of an x86 product that MacOS users aren't able to use without something like Parallels.

Onboarding:

Nix to just build it and get on with it. Read the flake.nix for information on the packages installed, the shellHook involved whereby I account for difference platforms(in my case, my M series Mac aka aarch64-darwin/aarch64-apple). Analyse `flake.nix` for further information.

Workflow and intent:

Building out the pipeline/workflow for the design of electronics, as well as integrating what we've built was required too. That was where I sought out tools such as:

- building `.sv`, `v` or `.vhdl` files
- running the test benches
- outputting a `.vcd` waveform file
- rendering the `.vcd` waveform file

For the typical flow, here's how I ran things:
- coding my `systemverilog` files
  - I would insert a section to output a `vcd` file. Example code is below:

  ```systemverilog
  // VCD generation - THIS CREATES THE WAVEFORM FILE
  initial begin
    $display("[%0t] Generating VCD file for waveform viewing", $time);
    $dumpfile("dump.vcd");
    $dumpvars(0, DPRAM_open_source_tb);
  end
  ```

- built the files using `iverilog`
  - example command: `iverilog -g2012 -o dpram_binary DPRAM_open_source.sv dpram_open_source_tb.s` (where `-g2012` is required to run `systemverilog` file)
  - this builds out a binary. 

- run the file using surfer
  - either insert the `.vcd` file into surfer via GUI or just run the command `surfer dump.vcd`(or whatever name the file you want to run is)

## Simulation

You can run the simulations using the following:

- `nvc` - VHDL
- `verilator` - Verilog


## Synthesis

- yosys
- nvc


Commands you can run for synthesis to hardware:

```bash
  yosys -p "read_verilog your_design.v; synth_ice40 -top your_entity -json output.json"
```
(this part hasn't  been tested yet due to lack of hardware)


Links to all the packages. Note how often they're maintained
| Package | Description | GitHub Repository |
|---------|-------------|-------------------|
| Yosys | Framework for Verilog RTL synthesis | https://github.com/YosysHQ/yosys |
| Verilator | SystemVerilog simulator and lint system | https://github.com/verilator/verilator |
| NVC | VHDL compiler and simulator | https://github.com/nickg/nvc |
| Git | Version control system | https://github.com/git/git |
| Iverilog | Icarus Verilog simulator | https://github.com/steveicarus/iverilog |
| UV | Fast Python package installer and resolver | https://github.com/astral-sh/uv |
| Verible | SystemVerilog parser, formatter, and lint tools | https://github.com/chipsalliance/verible |
| vhdl-ls | VHDL language server | https://github.com/VHDL-LS/rust_hdl |
| nextpnr | Portable FPGA place and route tool | https://github.com/YosysHQ/nextpnr |
| icestorm | Reverse-engineered tools for Lattice iCE40 FPGAs | https://github.com/YosysHQ/icestorm |


