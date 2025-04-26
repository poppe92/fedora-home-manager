{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

#    theme = "simple-tokyonight.rasi";

    plugins = [ 
      pkgs.rofi-emoji 
      pkgs.rofi-calc
      pkgs.rofi-power-menu
    ];

    extraConfig = { 
      modi = "drun";#,emoji
      show-icons = true;
      sort = true;
      icon-theme = "Papirus";

      drun-display-format = "{icon} {name}";
      display-drun = " Apps ";
      display-calc = " Calc ";
      #display-emoji = " Emojis ";
    };

    font = "Iosevka Nerd Font";

    theme = let
    # Use `mkLiteral` for string-like values that should show without
    # quotes, e.g.:
    # {
    #   foo = "abc"; => foo: "abc";
    #   bar = mkLiteral "abc"; => bar: abc;
    # };
    inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        #background-color = mkLiteral "transparent";
        #foreground-color = mkLiteral "rgba ( 250, 251, 252, 100 % )";
        #border-color = mkLiteral "#1f2335";


        background = mkLiteral "#000007";
        foreground = mkLiteral "#efc3e4";

        colors0 = mkLiteral "#000007";
        colors1 = mkLiteral "#03576B";
        colors2 = mkLiteral "#53586C";
        colors3 = mkLiteral "#315DA0";
        colors4 = mkLiteral "#A11197";
        colors5 = mkLiteral "#DE42D3";
        colors6 = mkLiteral "#3EA1B0";
        colors7 = mkLiteral "#efc3e4";
        colors8 = mkLiteral "#a7889f";
        colors9 = mkLiteral "#03576B";
        colors10 = mkLiteral "#53586C";
        colors11 = mkLiteral "#315DA0";
        colors12 = mkLiteral "#A11197";
        colors13 = mkLiteral "#DE42D3";
        colors14 = mkLiteral "#3EA1B0";
        colors15 = mkLiteral "#efc3e4";

        accent = mkLiteral "@yellow";
        urgent = mkLiteral "@red";

        background-color  = mkLiteral "@background";
        text-color        = mkLiteral "@colors14";
      };

      "#window" = {
        width = mkLiteral "35%";
        transparancy = "real";
        orientation = mkLiteral "vertical";
        border = mkLiteral "2px";
        border-color = mkLiteral "@colors0";
        border-radius = mkLiteral "10px";
      };

      "#mainbox" = {
        children = map mkLiteral [ "inputbar" "listview" "mode-switcher" ];
      };

      ## Element
      ## ----------------------

      "#element" = {
        padding = mkLiteral "8 14";
        border-radius = mkLiteral "5px";
      };

      "#element selected" = {
        text-color = mkLiteral "@colors0";
        background-color = mkLiteral "@colors1";
      };

      "#element-text" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "#element-icon" = {
        size = mkLiteral "24px";
        background-color = mkLiteral "inherit";
        padding = mkLiteral "0 6 0 0";
        alignment = mkLiteral "vertical";
      };

      "#listview" = {
        columns = mkLiteral "2";
        lines = mkLiteral "9";
        padding = mkLiteral "8 0";
        fixed-height = true;
        fixed-lines = true;
        border = mkLiteral "0 10 6 10";
      };

      ## Input Bar
      ## ----------------------

      "#entry" = {
        text-color = mkLiteral "@colors5";
        padding = mkLiteral "10 10 0 0";
        margin = mkLiteral "0 -2 0 0";
      };

      "#inputbar" = {
        background-image = mkLiteral "url(\"~/git/.dotfiles/neon-astronaut.jpg\", width)";
        padding = mkLiteral "200 0 0";
        margin = mkLiteral "0 0 0 0";
      };

      "#prompt" = {
        text-color = mkLiteral "@colors5";
        padding = mkLiteral "10 6 0 10";
        margin = mkLiteral "0 -2 0 0";
      };

    };

  };
}
