# Fedora Home Manager

Home Manager configuration for a Fedora workstation using Hyprland from the
`sdegler/hyprland` COPR. The active Hyprland configuration is
`modules/hyprland.lua`; `modules/hyprland.conf` is retained only as a historical
recovery reference and is not deployed.

## Ownership Policy

Fedora owns the operating-system boundary: kernel and Nvidia drivers,
PipeWire/WirePlumber, NetworkManager, Bluetooth, UPower, portals, PAM, polkit,
display management, and Flatpak.

The Hyprland COPR owns the version-coupled compositor family. Keep these RPMs
together so ABI and protocol versions stay compatible: `hyprland`, `hyprlock`,
`hypridle`, `hyprcursor`, `hyprlang`, `hyprutils`, `hyprgraphics`, and related
Hyprland tools. Home Manager deploys their user configuration but does not
install alternate Nix versions.

Home Manager owns ordinary user applications, developer tools, shell
configuration, and all tracked dotfiles. A program can be installed by Fedora
or COPR while its configuration is still managed by Home Manager. Do not install
the same executable through both RPM and Nix: `PATH` order would make the active
version ambiguous.

Current examples:

| Component | Package owner | Configuration owner |
| --- | --- | --- |
| Hyprland, Hyprlock, Hypridle, Waybar, swww, cliphist | Hyprland COPR | Home Manager |
| Rofi, Ghostty, Waypaper, Hyprshot, developer tools | Home Manager/Nix | Home Manager |
| wl-clipboard, NetworkManager, Bluetooth, polkit, KDE Connect | Fedora RPM | Fedora plus Hyprland startup config |

For a new user-level application, prefer Home Manager or a pinned upstream Nix
flake. Add a COPR only when it must integrate with Fedora system packages or it
provides a tightly coupled package family, as the Hyprland COPR does.

## Desktop Shell Profiles

`desktopShell` near the top of `home.nix` selects the desktop shell. It is
currently `"noctalia"`; set it to `"legacy"` to restore the established
Waybar, SwayNC, Rofi, Wlogout, Hyprlock, Hypridle, swww/Waypaper, and cliphist
workflow.

`"noctalia"` installs Noctalia from the flake's pinned nixpkgs and deploys the
curated TOML configuration at `modules/noctalia/config.toml`. No Fedora
repository or sudo operation is required. Hyprland reads the Home
Manager-generated `~/.config/hypr/shell-profile.lua`, so package selection and
the Lua startup/bindings always use the same profile.

To enable Noctalia:

1. Change `desktopShell = "legacy";` to `desktopShell = "noctalia";` in
   `home.nix`.
2. Apply the generation with `home-manager switch --flake .#jesper`.
3. Log out and back in to start the selected profile.

The first Noctalia evaluation replaces only Waybar/SwayNC and the legacy
launcher, notification, clipboard, and power-menu bindings. It preserves
Hyprlock, Hypridle, swww/Waypaper, cliphist's watcher, `nm-applet`,
`blueman-applet`, KDE Connect, the existing polkit agent, application startup,
and all Hyprland window-management bindings.

### Noctalia Theme Testing

The tracked Noctalia profile uses the built-in dark `Eldritch` palette. It
renders matching terminal colors for Ghostty at
`~/.config/ghostty/themes/noctalia` and selects that theme only while
`desktopShell = "noctalia"`.

The Noctalia profile also installs Starship and renders an Eldritch-colored,
af-magic-like Zsh prompt with user/host, directory, Git status, command
duration, exit status, and a second-line prompt character. Its generated
configuration is `~/.config/starship.toml`. FZF uses an Eldritch-aligned fixed
palette; Eza uses the same terminal ANSI colors through Ghostty. Bat remains on
its existing Dracula theme.

The files that Noctalia renders are sourced from
`modules/noctalia/ghostty.template` and `modules/noctalia/starship.template`.
They are separate from Home Manager's read-only Ghostty configuration, so
Noctalia never needs to modify a Nix-store symlink. After a manual Noctalia
palette change, apply the current palette immediately with:

```bash
noctalia msg templates-apply
```

To roll back, set `desktopShell` to `"legacy"`, run the same `home-manager
switch` command, then log out and back in. Legacy restores Ghostty's Dracula
theme, the Oh My Zsh `af-magic` prompt with no Starship integration, and the
previous FZF and Eza color mappings. Generated Noctalia theme files may remain
on disk but are not selected by the legacy configuration.

Noctalia's GUI writes runtime overrides to
`~/.local/state/noctalia/settings.toml`, which overrides the tracked TOML. Keep
long-term reproducible preferences in `modules/noctalia/config.toml`; inspect or
remove a conflicting runtime override when a tracked setting appears ignored.

## Applying Changes

Evaluate before applying changes:

```bash
home-manager build --flake .#jesper
```

Apply the evaluated configuration:

```bash
home-manager switch --flake .#jesper
```

After the first generation using this configuration, Hyprlock should come from
the Hyprland COPR instead of Nix:

```bash
command -v hyprlock
hyprlock --version
```

The expected executable is `/usr/bin/hyprlock` and it should report the COPR
version aligned with the installed Hyprland version.
