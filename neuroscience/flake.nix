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

        python-with-packages = pkgs.python313.withPackages (
          ps: with ps; [
            brian2
            matplotlib
            numpy
            python-lsp-server
          ]
        );
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
            neuron
            nushell
            python-with-packages
            ruff
            ruff-lsp
            tokei
            typst
            typstfmt
            typst-live
            typstyle
            tinymist
            uv
          ];

          shellHook = ''
            echo "Mojo + Brian2 environment loaded!"
            exec nu
          '';
        };
      }
    );
}
