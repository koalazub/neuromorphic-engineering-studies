{
  description = "Mojo Simulator flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mojo-playground.url = "github:franckrasolo/mojo-playground.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      mojo-playground,
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
          buildInputs = [
            (mojo-playground.packages.${system}.default or null)
          ];

          packages = with pkgs; [
            direnv
            git
            just
            nushell
            python313Packages.brian2
            python313Packages.matplotlib
            python313Packages.numpy
            ruff
            ruff-lsp
            tokei
            typst
            typstfmt
            typst-live
          ];

          shellHook = ''
            echo "Mojo + Brian2 environment loaded!"
            exec nu
          '';
        };
      }
    );
}
