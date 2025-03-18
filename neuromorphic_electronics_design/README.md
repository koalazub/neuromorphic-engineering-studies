# SystemVerilog Development Environment

This repository provides a Nix-based development environment for SystemVerilog projects.

## Installation

1. Clone this repository
2. Make sure you have [Nix](https://nixos.org/download.html) installed with flakes enabled
3. Run the development environment:
   ```bash
   nix develop
   ```

The flake automatically installs UTM (Universal Type Manager) for virtualisation, which is required to run Prime on macOS. Note that UTM is a large package, so the initial download may take some time.

## Running Quartus Prime on macOS

Since Quartus Prime doesn't run natively on macOS (especially on Apple Silicon Macs), you'll need to use virtualisation:

1. Download a Windows ISO from Microsoft's website
2. Run UTM from the terminal:
   ```bash
   utm
   ```
3. Create a new virtual machine with the Windows ISO
4. Once Windows is installed, download and install Quartus Prime Lite from Intel's website
5. Use the VM to develop and compile your SystemVerilog projects

## Development Tools Included

The flake provides:
- **iverilog**: Icarus Verilog for simulation
- **verilator**: For linting and synthesis
- **python3**: For cocotb (testbench framework)
- **UTM**: For virtualisation to run Quartus Prime
- **git**: For version control
- **surfer**: For waveform visualisation (on Apple Silicon Macs)
- **verible**: For SystemVerilog formatting and linting (not available on Apple Silicon Macs unless you install via Homebrew)

## Running, Compiling and Simulating

### Simulation with Icarus Verilog

This compiles the verilog code and generates the waves that can be run
```bash
iverilog -o my_design my_design.sv my_testbench.sv
vvp my_design
```

### Linting with Verilator
```bash
verilator --lint-only my_design.sv
```

### Viewing Waveforms
```bash
surfer my_simulation.vcd
```

## Notes for Apple Silicon (M Series) Mac Users

- Verible is not available natively on ARM architecture
- Consider using Rosetta 2 to run Nix in x86_64 mode for full functionality
- Quartus Prime must be run through a Windows or Linux virtual machine using UTM
- Surfer is provided as an alternative waveform viewer for Apple Silicon Macs



Here's how to run your SystemVerilog code using Icarus Verilog (iverilog):

## Basic Iverilog Workflow

### Step 1: Compile your code
```bash
iverilog -g2012 -o simulation_output up_down.sv up_down_tb.sv
```

Breaking down this command:
- `iverilog`: The Icarus Verilog compiler
- `-g2012`: Specifies SystemVerilog-2012 standard (important for SystemVerilog features)
- `-o simulation_output`: Names the output executable
- `up_down.sv up_down_tb.sv`: Your source files (design and testbench)

### Step 2: Run the simulation
```bash
vvp simulation_output
```

This executes the compiled simulation and produces the output according to your `$monitor` and other display statements.

### Step 3: View waveforms (optional)
If you used `$dumpfile` and `$dumpvars` in your testbench:
```bash
surfer up_down_testbench.vcd
```

## Complete Example

Assuming you have two files:
- `up_down.sv` (containing your module)
- `up_down_tb.sv` (containing your testbench)

Run these commands:

```bash
# Compile
iverilog -g2012 -o sim_out up_down.sv up_down_tb.sv

# Run simulation
vvp sim_out

# View waveforms (if you have surfer installed)
surfer up_down_testbench.vcd
```

## Common Options

- `-Wall`: Enable all warnings
- `-g2012`: Use SystemVerilog-2012 standard
- `-I`: Include directory for finding modules
- `-D`: Define a preprocessor macro

## Debugging Tips

1. If you get syntax errors, check that you're using `-g2012` for SystemVerilog
2. Make sure all your files are in the same directory or use `-I` to specify include paths
3. Use `$display` statements in your testbench for debugging specific values

For your specific up_down counter example, the commands above should work as long as both your module and testbench are saved in separate .sv files.
