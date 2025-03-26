{
  description = "Mathematics of Signal Processing dev env";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
            allowUnfree = true;
          };
        };

      in
      {

        devShells.default = pkgs.mkShell {
          name = "maths-signal-processing";
          buildInputs = with pkgs; [
            jupyter
            git
            uv
          ];
          shellHook = ''
            if command -v nu >/dev/null; then
              exec nu
            else
              echo "nu not found, skipping shell hook"
            fi
          '';
        };

        devShells.mojo = mojoPlayground.lib.mkShell {
          inherit system;
          projectName = "maths-signal-processing";
        };
      }
    );
}
