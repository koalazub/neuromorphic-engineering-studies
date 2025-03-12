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
        pkgs = import nixpkgs { 
          inherit system; 
          config = { 
            allowUnsupportedSystem = true;
          };
        };
        
        # Check if the system is aarch64-darwin (M1/M2 Mac)
        isAarch64Darwin = system == "aarch64-darwin";
        
        # Create a list of packages based on system architecture
        commonPackages = with pkgs; [
          iverilog # Icarus Verilog for simulation
          verilator # Verilator for linting and synthesis
          gtkwave # GTKWave for waveform visualization
          python3 # Python for cocotb (testbench framework)
          quartus-prime-lite
        ];
        
        # Add Verible only if not on aarch64-darwin, or try with allowUnsupportedSystem
        veriblePackage = if !isAarch64Darwin then [ pkgs.verible ] else [];
        
        # Alternative LSP for aarch64-darwin (if available)
        alternativeLspPackages = if isAarch64Darwin then [
          # You could add alternative LSP servers here if available
          # For example: pkgs.svls or other compatible tools
        ] else [];
        
        allPackages = commonPackages ++ veriblePackage ++ alternativeLspPackages;
      in
      {
        devShells.default = pkgs.mkShell {
          name = "nm-elec-design";

          # Add packages for SystemVerilog development
          packages = allPackages;

          # Environment variables and shell hook
          shellHook = ''
            ${if builtins.length veriblePackage > 0 then "export PATH=$PATH:${pkgs.verible}/bin" else ""}
            
            echo "SystemVerilog dev environment loaded!"
            ${if isAarch64Darwin then ''
              echo "Note: Running on aarch64-darwin (M1/M2 Mac)"
              ${if builtins.length veriblePackage == 0 then ''
                echo "Warning: Verible is not available on this platform."
                echo "Consider using Rosetta 2 to run Nix in x86_64 mode for full functionality."
              '' else ""}
            '' else ""}
            
            if command -v nu >/dev/null 2>&1; then
              exec nu
            fi
          '';
        };
      }
    );
}

