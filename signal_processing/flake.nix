{
  description = "Development environment with Python, Mojo, Jupyter, and Julia";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true; # Mojo currently has a proprietary license
          };
        };

        pythonEnv = pkgs.python3.withPackages (ps: with ps; [
          jupyter
          notebook
          ipykernel
          numpy
          pandas
          matplotlib
        ]);

        juliaEnv = pkgs.mkShell {
          buildInputs = [ pkgs.julia-bin ]; # Use the binary distribution
          shellHook = ''
            julia -e '
              using Pkg
              try
                Pkg.add("LanguageServer")
              catch e
                @warn "Failed to install LanguageServer: $e"
              end
            '
          '';
        };

        # Placeholder for Mojo - you'll need to figure out how to install it
        #mojo = null; # Replace with a valid Mojo package if you can find one
        #mojo = pkgs.callPackage ./path/to/mojo.nix { }; # Example using a local definition

      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pythonEnv
            juliaEnv
            #mojo # Include when you have a valid Mojo package
            pkgs.nushell # Adding nushell for the shellHook
          ];

          shellHook = ''
            if command -v nu >/dev/null 2>&1; then
              exec nu
            else
              echo "nu command not found, skipping shellHook"
            fi
          '';
        };

        packages = {
          pythonEnv = pythonEnv;
        };
      }
    );
}
