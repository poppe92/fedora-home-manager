{ pkgs, desktopShell, ... }: {
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;

    # Enable for whichever shell you plan to use!
    #enableBashIntegration = true;
    #enableFishIntegration = true;
    enableZshIntegration = true;

    settings = {
      # Noctalia writes its palette to themes/noctalia; legacy keeps today's
      # standalone Dracula theme without depending on Noctalia state.
      theme = if desktopShell == "noctalia" then "noctalia" else "Dracula";
      background-opacity = "0.95";
      font-family = "JetBrains Mono";
      working-directory = "home";
      window-inherit-working-directory = false;
      tab-inherit-working-directory = false;
    };
  };
}
