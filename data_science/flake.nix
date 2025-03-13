{
  description = "Data science flake that requires R for uni work";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
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
        };
        r-packages = with pkgs.rPackages; [
          dplyr
          tidyr
          readr
          tibble
          ggplot2
          scales
          isoband
          MASS
          mgcv
          knitr
          rmarkdown
          languageserver
        ];
      in
      {
        devShells = {
          default = pkgs.mkShell {
            buildInputs =
              with pkgs;
              [
                git
                harper
                R
              ]
              ++ r-packages
              ++ (with pkgs; [
                typst
                typstfmt
                typst-live
              ]);

            shellHook = ''
              if command -v nu >/dev/null 2>&1; then
                exec nu
              else
                echo "nu command not found, skipping shellHook"
              fi

              echo "R environment with data science packages ready!"
              echo "Run 'R' to start an interactive R session"
              echo "Or run 'Rscript your_script.R' to execute an R script"
            '';
          };
        };
      }
    );
}
