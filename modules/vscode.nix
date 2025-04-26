# vscode.nix

{
  pkgs,
  ...
}: 
let
#  agCommand = "ag --hidden --ignore .dit -g ''";
in
{
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      dracula-theme.dracule-theme
      vscodevim.vim
      ms-vscode.live-server
      esbenp.prettier-vscode
    ];

  };
}

