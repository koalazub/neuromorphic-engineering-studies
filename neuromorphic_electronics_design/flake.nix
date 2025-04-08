{
  description = "Neuromorphic Electronic Design with integrated Mojo Playground";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mojoPlayground.url = "github:franckrasolo/mojo-playground.nix";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      mojoPlayground,
      ...
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

        # Platform detection
        isAarch64Darwin = system == "aarch64-darwin";

        # Custom Yosys package with checkPhase skipped
        customYosys = pkgs.yosys.overrideAttrs (oldAttrs: {
          doCheck = false;
          checkPhase = "";
        });

        # Common packages for all platforms
        commonPackages = with pkgs; [
          verilator # Verilator for linting and synthesis
          python3 # For cocotb (testbench framework)
          nvc
          git
          iverilog
          uv
          verible
        ];

        # VHDL specific packages
        vhdlPackages = with pkgs; [
          # ghdl # GHDL for VHDL simulation and analysis
          customYosys # Using our modified Yosys that skips checkPhase
          vhdl-ls
        ];

        # Optional FPGA-specific tools
        fpgaTools = with pkgs; [
          nextpnr # Place and route tool
          icestorm # For Lattice iCE40 FPGAs
        ];

        # Platform-specific packages and configuration
        platformSpecific =
          if isAarch64Darwin then
            {
              # Configuration for aarch64-darwin (M1/M2 Mac)
              additionalPackages = [ pkgs.surfer ];
              veribleAvailable = false;
              shellHookMsg = ''
                echo "Note: Running on aarch64-darwin (M1/M2 Mac)"
                echo "Warning: Verible is not available on this platform."
                echo "Consider using Rosetta 2 to run Nix in x86_64 mode for full functionality."
              '';
            }
          else
            {
              # Configuration for other platforms
              additionalPackages = [ pkgs.verible ];
              veribleAvailable = true;
              shellHookMsg = "";
            };

        allPackages = commonPackages ++ vhdlPackages ++ fpgaTools ++ platformSpecific.additionalPackages;

        veriblePathSetup =
          if platformSpecific.veribleAvailable then "export PATH=$PATH:${pkgs.verible}/bin\n" else "";
      in
      {
        devShells = {
          default = pkgs.mkShell {
            name = "nm-elec-design";
            packages = allPackages;
            shellHook = ''
              ${veriblePathSetup}
              echo "HDL dev environment loaded with VHDL and SystemVerilog support!"
              ${platformSpecific.shellHookMsg}
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
            extraPackages = allPackages;
          };
        };
      }
    );
}
