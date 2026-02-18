{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;

    # Enable for whichever shell you plan to use!
    #enableBashIntegration = true;
    #enableFishIntegration = true;
    enableZshIntegration = true;

    settings = {
      theme = "Dracula";
      background-opacity = "0.95";
      font-family = "JetBrains Mono";
      working-directory = "home";
      window-inherit-working-directory = false;
    };
  };
}
