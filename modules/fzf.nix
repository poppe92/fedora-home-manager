{
  pkgs,
  desktopShell,
  ...
}: 
let
  agCommand = "ag --hidden --ignore .dit -g ''";
in
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    defaultCommand = agCommand;

    colors = if desktopShell == "noctalia" then {
      fg = "#ebfafa";
      bg = "#212337";
      hl = "#7081d0";
      "fg+" = "#ffffff";
      "bg+" = "#292e42";
      "hl+" = "#a48cf2";
      info = "#04d1f9";
      prompt = "#37f499";
      pointer = "#37f499";
      marker = "#e9f941";
      spinner = "#04d1f9";
      header = "#9071f4";
    } else {
      fg = "#dedede";
      bg = "#121212";
      hl ="#666666";
      "fg+" = "#eeeeee";
      "bg+" = "#282828";
      "hl+" = "#cf73e6";
      info = "#cf73e6";
      prompt ="#FF0000";
      pointer = "#cf73e6";
      marker = "#f0d50c";
      spinner = "#cf73e6";
      header ="#91aadf";
    };

    defaultOptions = [
      "--height 40%"
      "--border"
    ];

    historyWidgetOptions = [
      "--sort"
      "--exact"
    ];

  };
}
