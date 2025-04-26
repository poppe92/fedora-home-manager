{
  pkgs,
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

    colors = {
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

