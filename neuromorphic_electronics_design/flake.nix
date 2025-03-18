{
  description = "Neuromorphic Electronic Design";

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
            allowUnfree = true;
          };
        };

        isAarch64Darwin = system == "aarch64-darwin";

        commonPackages = with pkgs; [
          iverilog # Icarus Verilog for simulation
          verilator # Verilator for linting and synthesis
          python3 # Python for cocotb (testbench framework)
          utm
          git
        ];

        veriblePackage = if !isAarch64Darwin then [ pkgs.verible ] else [ ];

        alternativeLspPackages =
          if isAarch64Darwin then
            [
              pkgs.surfer
            ]
          else
            [ ];

        allPackages = commonPackages ++ veriblePackage ++ alternativeLspPackages;
      in
      {
        devShells.default = pkgs.mkShell {
          name = "nm-elec-design";

          packages = allPackages;

          shellHook = ''
            ${if builtins.length veriblePackage > 0 then "export PATH=$PATH:${pkgs.verible}/bin" else ""}

            echo "SystemVerilog dev environment loaded!"
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
            fi
          '';
        };
      }
    );
}
