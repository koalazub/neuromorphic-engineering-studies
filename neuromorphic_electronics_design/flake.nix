{
  description = "SystemVerilog Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "systemverilog-dev-env";

          # Add packages for SystemVerilog development
          packages = with pkgs; [
            # iverilog # Icarus Verilog for simulation
            # verilator # Verilator for linting and synthesis
            gtkwave # GTKWave for waveform visualization
            python3 # Python for cocotb (testbench framework)
            # verible # Verible tools (includes LSP server)
          ];

          # Environment variables (if needed)
          shellHook = ''
            export PATH=$PATH:${pkgs.verible}/bin
              if command -v nu >/dev/null 2>&1; then
                exec nu
                echo "SystemVerilog dev environment loaded!"
              else
                echo "nu command not found, skipping shellHook"
              fi
          '';
        };
      }
    );
}
