{
  description = "dev env for multiplication table";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      rust-overlay,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        rustVersion = pkgs.rust-bin.stable.latest.default;
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustVersion
            cargo
            go
            gopls
            rustfmt
            rust-analyzer
            pkg-config
            openssl
          ];
          shellHook = ''
            if command -v nu >/dev/null 2>&1; then
              exec nu
            else
              echo "nu command not found, skipping shellHook"
            fi
          '';

        };
      }
    );
}
