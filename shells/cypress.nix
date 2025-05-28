# flake.nix

{ 
description = "Flake to manage my Java workspace.";

inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";
inputs.flake-utils.url = "github:numtide/flake-utils";

outputs = inputs: 
let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in { 
  devShell.${system} = pkgs.mkShell rec {
    name = "cypress-and-npm-shell";
    nativeBuildInputs = with pkgs; [ 
      nodejs
      cypress
    ];

    shellHook = ''
      export CYPRESS_INSTALL_BINARY=0
      export CYPRESS_RUN_BINARY=${pkgs.cypress}/bin/Cypress
      chmod +w $HOME/.config/Cypress -R # Nix files, copied from store is read only, after first run, reload direnv when files exist
    '';
  };
 };
}
