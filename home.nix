{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules/git.nix
    ./modules/fzf.nix
    ./modules/zshrc.nix
    ./modules/eza.nix
    ./modules/zoxide.nix
#    ./modules/neovim/neovim.nix

    ## Linux Specific Modules
    ./modules/rofi.nix

    ## Hyprland things (Not working atm)
    #./modules/hyprland.nix
    #./modules/hyprlock.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Set target to non-NixOS Linux
  targets.genericLinux.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jesper";
  home.homeDirectory = "/home/jesper";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # Development Tools
    # git
    nil # Language server for Nix
    alejandra # Nix Formatter for Neovim
    jq
    fx
    quarkus
    direnv

    # Terminal programs
    silver-searcher # Better find files
    kubectl
    zip
    unzip
    _7zz
    fzf
    k9s
    bat # Cat replacement
    #eza # LS replacement
    bind # DNS System Lookup tools like "dig"
    tldr
    kubernetes-helm

    # Zsh Used Packages
    lolcat
    cowsay
    fortune


    # Build Tools
    
    maven
    #(azure-cli.withExtensions [
    #  azure-cli.extensions.azure-devops
    #])
    nodejs
    yarn
    magic-wormhole

    # Hyperland specific (Not working if not fully managed in Nix Home Manager)
    # If not managed in nix, install package with DNF
    waypaper
    hyprshot

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    ".config/hypr/hyprland.conf".source = modules/hyprland.conf;
    ".config/hypr/hyprlock.conf".source = modules/hyprlock.conf;
    ".config/hypr/hypridle.conf".source = modules/hypridle.conf;

    ".config/wlogout".source = modules/wlogout;
    ".config/wlogout".recursive = true;

    ".config/waybar".source = modules/waybar;
    ".config/waybar".recursive = true;

    ".config/swaync".source = modules/swaync;
    ".config/swaync".recursive = true;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nixos/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    # DISPLAY="$(grep nameserver /etc/resolv.conf | awk '{print $2}'):0";
    #DISPLAY="${DISPLAY:-$(grep -Po '(?<=nameserver ).*' /etc/resolv.conf):0}";
    QUARKUS_PROFILE="dev";
    NIXPKGS_ACCEPT_ANDROID_SDK_LICENSE=1;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Enable Java
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };

#  xdg = {
#    userDirs = {
#      enable = true;
#      createDirectories = true;
#    };
#  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
