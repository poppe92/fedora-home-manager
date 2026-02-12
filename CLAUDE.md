# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Nix Home Manager configuration for managing a Fedora Linux desktop environment. It uses flakes for reproducibility and follows a modular architecture.

## Common Commands

```sh
# Build and activate the home-manager configuration
home-manager switch --flake .

# Alternative: build only (creates ./result symlink)
nix build .#homeConfigurations."jesper".activationPackage
./result/activate
```

## Architecture

- **`flake.nix`** - Flake entry point, defines home-manager configuration for user "jesper"
- **`home.nix`** - Main configuration file that imports modules and defines packages
- **`modules/`** - Modular Nix files for individual tools (git, zsh, rofi, etc.)
- **`shells/`** - Dev shell flakes for different environments (Java versions, cypress, etc.)
- **`scripts/`** - Utility shell scripts

### Module Pattern

Modules follow the standard home-manager pattern:

```nix
{ pkgs, config, ... }: {
  programs.<name> = {
    enable = true;
    # configuration
  };
}
```

### Dotfile Management

Static config files are symlinked via `home.file` in `home.nix`:

```nix
home.file = {
  ".config/hypr/hyprland.conf".source = modules/hyprland.conf;
  ".config/waybar".source = modules/waybar;
};
```

## Key Notes

- Hyprland is installed outside Nix (via DNF/JaKooLit), only configs are managed here
- Uses `nixpkgs-unstable` and `home-manager/master`
- Username is "jesper", home directory is `/home/jesper`
- Nix formatter: `alejandra`
- LSP for Nix: `nil`