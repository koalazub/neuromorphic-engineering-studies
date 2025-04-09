{
  description = "Neuroscience development envrironment for reports and documentation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mojo-playground.url = "github:franckrasolo/mojo-playground.nix";
    tinymist = {
      url = "github:Myriad-Dreamin/tinymist/main";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      mojo-playground,
      tinymist,
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

        python-with-packages = pkgs.python313.withPackages (
          ps: with ps; [
            brian2
            matplotlib
            numpy
            python-lsp-server
          ]
        );

        tinymistPkg = pkgs.rustPlatform.buildRustPackage {
          pname = "tinymist";
          version = "main";
          src = tinymist;
          cargoHash = "sha256-r2HVxsq9DyliU2ec06Lgz3Ihlvm7DtWbGvDp9RXM0T8=";
          doCheck = false;
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
            neuron
            nushell
            python-with-packages
            ruff
            ruff-lsp
            tokei
            harper
            typst
            typstfmt
            typst-live
            typstyle
            tinymistPkg
            uv
            jetbrains-mono
          ];

          shellHook = ''
            echo "Neuroscience dev env entered"
            exec nu
          '';
        };
      }
    );
}
