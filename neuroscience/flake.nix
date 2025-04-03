{
  description = "Mojo Simulator flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mojo-playground.url = "github:franckrasolo/mojo-playground.nix";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      mojo-playground,
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

        pythonWithPip = pkgs.python313.withPackages (
          ps: with ps; [
            pip
            setuptools
            wheel
            cython
          ]
        );

        neuron = pkgs.stdenv.mkDerivation {
          pname = "neuron";
          version = "8.2.6";

          src = pkgs.fetchgit {
            url = "https://github.com/neuronsimulator/nrn.git";
            rev = "8.2.6";
            sha256 = "sha256-xASBpsF8rIzrb5G+4Qi6rvWC2wqL7nAGlSeMsBAI6WM=";
            fetchSubmodules = true;
          };

          nativeBuildInputs = with pkgs; [
            bison
            cmake
            flex
            git
            perl
            pkg-config
            pythonWithPip
            makeWrapper
          ];

          buildInputs = with pkgs; [
            readline
            ncurses
            python313Packages.numpy
            python313Packages.cython
            python313Packages.mpi4py
            python313Packages.pep517
          ];

          PYTHONPATH = "${pkgs.python313Packages.cython}/${pkgs.python313.sitePackages}:${pkgs.python313Packages.setuptools}/${pkgs.python313.sitePackages}";

          # Prevent pip from network access - needed for the nrn libarys' shit
          PIP_NO_CACHE_DIR = 1;
          PIP_NO_INDEX = 1;

          cmakeFlags = [
            "-DNRN_ENABLE_INTERVIEWS=OFF"
            "-DNRN_ENABLE_RX3D=OFF"
            "-DNRN_ENABLE_CORENEURON=OFF"
            "-DNRN_ENABLE_TESTS=OFF"
            "-DNRN_ENABLE_PYTHON=ON"
            "-DNRN_ENABLE_MODULE_INSTALL=ON"
            "-DPYTHON_EXECUTABLE=${pythonWithPip}/bin/python"
          ];

          preConfigure = ''
                        # Create a local wheel directory with pre-downloaded packages
                        mkdir -p $TMPDIR/wheelhouse

                        # Create a simple fake pip script that always succeeds
                        mkdir -p $TMPDIR/bin
                        cat > $TMPDIR/bin/pip <<EOF
            #!/bin/sh
            echo "Using fake pip that always succeeds"
            exit 0
            EOF
                        chmod +x $TMPDIR/bin/pip

                        ln -s ${pythonWithPip}/bin/python $TMPDIR/bin/py
                        ln -s ${pythonWithPip}/bin/python $TMPDIR/bin/python3

                        export PATH=$TMPDIR/bin:$PATH
                        export PIP_NO_BUILD_ISOLATION=1
          '';

          postInstall = ''
            pythonSitePackages=$out/lib/${pkgs.python313.libPrefix}/site-packages
            mkdir -p $pythonSitePackages
            if [ -d "$out/lib/python" ]; then
              cp -r $out/lib/python/* $pythonSitePackages/
            fi

            for prog in $out/bin/*; do
              if [ -f "$prog" ] && [ -x "$prog" ]; then
                wrapProgram "$prog" --prefix PYTHONPATH : "$pythonSitePackages:$PYTHONPATH"
              fi
            done
          '';
        };

        neuronPython = pkgs.python313Packages.toPythonModule neuron;

        pythonWithNeuron = pkgs.python313.withPackages (
          ps: with ps; [
            matplotlib
            numpy
            brian2
            xlib
          ]
        );

      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            (mojo-playground.packages.${system}.default or null)
            pkgs.autoreconfHook
            pkgs.xorg.utilmacros
            neuron
            neuronPython
            pythonWithNeuron
          ];

          packages = with pkgs; [
            direnv
            git
            just
            nushell
            ruff
            ruff-lsp
            tokei
            typst
            typstfmt
            typst-live
            typstyle
            tinymist
          ];

          shellHook = ''
            echo "Mojo + Brian2 + NEURON environment loaded!"

            export NEURON_HOME="${neuron}"
            export PATH="$NEURON_HOME/bin:$PATH"

            export PYTHONPATH="${neuronPython}/${pkgs.python313.sitePackages}:${pythonWithNeuron}/${pkgs.python313.sitePackages}:$PYTHONPATH"

            echo "NEURON_HOME: $NEURON_HOME"
            echo "PYTHONPATH: $PYTHONPATH"

            if [[ "$(uname -m)" == "arm64" ]]; then
              export ARCHPREFERENCE=arm64
            fi

            python -c "import sys; print('Python path:'); [print(p) for p in sys.path]"
            python -c "import os; print('NEURON_HOME:', os.environ.get('NEURON_HOME'))"
            python -c "try: from neuron import h; print('Successfully imported neuron.h'); except Exception as e: print('Error importing neuron.h:', e)"

            if [ -t 0 ]; then
              exec nu
            fi
          '';
        };
      }
    );
}
