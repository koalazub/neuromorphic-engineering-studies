Below is a list of tools that I've managed to marshal to get started with my studies doing neuromorphic electronics design.

The intent was to:

- find open source tooling that is maintained and open source
- able to be interacted with on a cross-platform basis
- easy to onboard others if they wanted to use the same tools consistently

Onboarding:

Onboarding has always been a pain point, and so I leaned on Nix to just build it and get on with it. Read the flake.nix for information on the packages installed, the shellHook involved whereby I account for difference platforms(in my case, my M series Mac aka aarch64-darwin/aarch64-apple). Analyse `flake.nix` for further information.

Workflow and intent:

Building out the pipeline/workflow for the design of electronics, as well as integrating what we've built was required too. That was where I sought out tools such as `
# Building out the open source quartus workflow for mac

I build out my flow by doing the following:

- I write my code using verilog/systemverilog
- build the code using nvc(open source VHDL simulator and compiler based on IEEE standards )
  - or even better is GHDL provided it's installed via `homebrew` if using mac
