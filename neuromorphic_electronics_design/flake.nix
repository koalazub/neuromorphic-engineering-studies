{
  description = "Neuromorphic Electronic Design with integrated Mojo Playground";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mojoPlayground.url = "github:franckrasolo/mojo-playground.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      mojoPlayground,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnsupportedSystem = true;
            allowUnfree = true;
          };
        };

        isAarch64Darwin = system == "aarch64-darwin";

        # VHDL specific packages
        vhdlPackages = with pkgs; [
          # ghdl # GHDL for VHDL simulation and analysis
          yosys # Synthesis framework
          vhdl-ls
        ];

        # Optional FPGA-specific tools
        fpgaTools = with pkgs; [
          nextpnr # Place and route tool
          icestorm # For Lattice iCE40 FPGAs
        ];

        commonPackages = with pkgs; [
          # iverilog # Icarus Verilog for simulation
          verilator # Verilator for linting and synthesis
          python3 # For cocotb (testbench framework)
          verible
          nvc
          utm
          git
          uv
        ];

        veriblePackage = if !isAarch64Darwin then [ pkgs.verible ] else [ ];
        alternativeLspPackages = if isAarch64Darwin then [ pkgs.surfer ] else [ ];
      in
      {
        devShells = {
          default = pkgs.mkShell {
            name = "nm-elec-design";
            packages = commonPackages ++ vhdlPackages ++ fpgaTools ++ veriblePackage ++ alternativeLspPackages;
            shellHook = ''
              ${if builtins.length veriblePackage > 0 then "export PATH=$PATH:${pkgs.verible}/bin\n" else ""}
              echo "HDL dev environment loaded with VHDL and SystemVerilog support!"
              ${
                if isAarch64Darwin then
                  ''
                    echo "Note: Running on aarch64-darwin (M1/M2 Mac)"
                    ${
                      if builtins.length veriblePackage == 0 then
                        ''
                          echo "Warning: Verible is not available on this platform."
                          echo "Consider using Rosetta 2 to run Nix in x86_64 mode for full functionality."
                        ''
                      else
                        ""
                    }
                  ''
                else
                  ""
              }
              if command -v nu >/dev/null 2>&1; then
                exec nu
              else
                echo "nu command not found, skipping shellHook"
              fi
            '';
          };

          mojo = mojoPlayground.lib.mkShell {
            inherit system;
            projectName = "neuromorphic-mojo-project";
            extraPackages =
              commonPackages ++ vhdlPackages ++ fpgaTools ++ veriblePackage ++ alternativeLspPackages;
          };
        };
      }
    );
}
