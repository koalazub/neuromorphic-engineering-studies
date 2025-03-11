{
  description = "Data science flake that requires R for uni work";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    # mojo.url = "github:noverby/noverby";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    # mojo,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              git
              # mojo.packages.${system}.mojo # check later when ready
              harper
              R
              typst
              typstfmt
              typst-live
            ];

            shellHook = ''
              if command -v nu >/dev/null 2>&1; then
                exec nu
              else
                echo "nu command not found, skipping shellHook"
              fi
            '';
          };
        };
      }
    );
}
