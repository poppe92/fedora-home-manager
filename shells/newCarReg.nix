# shell.nix

# Setup npm global directory in home folder -> https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally#manually-change-npms-default-directory

{ 
description = "Flake to manage my Java workspace.";

inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";
inputs.flake-utils.url = "github:numtide/flake-utils";

outputs = inputs: 
let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};

  pkgsNode6 = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/28e0126876d688cf5fd15da1c73fbaba256574f0.tar.gz";
    sha256 = "0wh3zwj9zvypkj0f7xqw76phhag9ys7vlsp6ixv90br52m61x4v4";
  }) {
    inherit system;
  };

  pkgsNode8 = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/0bcbb978795bab0f1a45accc211b8b0e349f1cdb.tar.gz";
    sha256 = "0c3mpc5z7ilgpgr9rhn42vmwhygza6n2yg7lyhgjf0yym4prnxn9";
  }) {
    inherit system;
  };

  pkgsNode12 = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/ee355d50a38e489e722fcbc7a7e6e45f7c74ce95.tar.gz";
    sha256 = "18wixs4xvnsnfsj48d29ryvvh2jdqadqnnd05kvjkqdmgmllqbky";
  }) {
    inherit system;
  };

  myNodejs6 = pkgsNode6.nodejs;
  myNodejs8 = pkgsNode8.nodejs-8_x;
  myNodejs12 = pkgsNode12.nodejs-12_x;

in { 
  devShell.${system} = pkgs.mkShell rec {
    name = "java-shell";
    nativeBuildInputs = with pkgs; [ 
      jdk11
#      myNodejs6
#      myNodejs8
      myNodejs12
    ];
    
    shellHook = ''
      export JAVA_HOME=${pkgs.jdk11}
      PATH="${pkgs.jdk11}/bin:$PATH"
      export PATH=~/.npm-global/bin:$PATH
    '';
  };
 };
}
