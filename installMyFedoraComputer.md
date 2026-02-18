# Setup Work computer on Linux

## Install Fedora Workstation 

### Install Microsoft Intune for managing computer

Go to `https://learn.microsoft.com/en-us/intune/intune-service/user-help/microsoft-intune-app-linux` and run commands for RHEL, 
note that config-manager needs `dnf4` so the add-repo command is:

```sh
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf4 config-manager --add-repo https://packages.microsoft.com/yumrepos/microsoft-rhel9.0-prod
sudo dnf install --releasever=41 java-11-openjdk 
```

After that you need to run this to install java-11-openjdk (its not supported after fedora 41)

`sudo dnf install --releasever=41 java-11-openjdk`

Then you can install the intune-portal

`sudo dnf install intune-portal`


### Fix Sound 9i Pro

```url
https://github.com/maximmaxim345/yoga_pro_9i_gen9_linux
```

### Install common packages

```sh
mkdir ~/git
sudo dnf install swaylock timeshift hyprlock golang hyprshot evolution evolution-ews desktop-file-utils lxpolkit blueman azure-cli
sudo dnf install dotnet-sdk-8.0
sudo dnf copr enable yuezk/globalprotect-openconnect
sudo dnf install globalprotect-openconnect discord xclip xsel seahorse gnome-keyring i2c-tools nmtui 
sudo dnf install magic-wormhole golang
sudo dnf copr enable scottames/ghostty
sudo dnf install ghostty
flatpak install com.usebruno.Bruno 
flatpak install flathub com.spotify.Client
flatpak install slack
```

```sh
git clone git@github.com:poppe92/obsidianNotes.git
git clone git@github.com:poppe92/.dotfiles
```

Timeshift is for rollback possiblities, create backup after signing Nvidia drivers

### Install VS-Code

```sh
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install code
```

### Install Dbeaver

```sh
wget https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm
sudo dnf install ./dbeaver-ce-latest-stable.x86_64.rpm
```

### Update DNS server

sudoedit /etc/systemd/resolved.conf

```conf
[Resolve]
DNS=8.8.8.8 8.8.4.4
```

### Set Hostname

```sh
sudo hostnamectl set-hostname "jesper-fedora"
```

### Set crypto policy to legacy for Older SSH-RSA connections

```sh
sudo update-crypto-policies --set DEFAULT
```

### Update Zen Browser to not blur text

Change these setting values in `about:config`:

```config
zen.view.experimental-rounded-view=false
gfx.font_rendering.cleartype_params.rendering_mode = 5
gfx.font_rendering.cleartype_params.enhanced_contrast = 1 
```

New info, flatpak has memory leaks, use this copr instead:

```sh
sudo dnf copr enable sneexy/zen-browser
sudo dnf install zen-browser
xdg-settings set default-web-browser app.zen_browser.zen.desktop
```

Add zen as allowed browser for 1password (see: https://docs.zen-browser.app/guides/1password)

```sh
sudo touch /etc/1password/custom_allowed_browsers
echo "zen-bin" | sudo tee -a /etc/1password/custom_allowed_browsers
```

### Get AppImageLauncher

```url
https://github.com/TheAssassin/AppImageLauncher
```

get RPM Package
`sudo dnf localinstall ~/Downloads/AppImageLauncher.rpm` with the right path

### Docker

```sh
sudo dnf -y install dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

If prompted to accept the GPG key, verify that the fingerprint matches 060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35, and if so, accept it.

```sh
sudo systemctl start docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world
```

## Install Nvidia (and sign my drivers)

```url
https://rpmfusion.org/Howto/NVIDIA
https://rpmfusion.org/Howto/Secure%20Boot
```

## Install Hyperland

```sh Install Hyperland with JaKoolIt
git clone --depth=1 https://github.com/JaKooLit/Fedora-Hyprland.git ~/Fedora-Hyprland
cd ~/Fedora-Hyprland
chmod +x install.sh
./install.sh
```

### Install Hyperland-per-window-layout

Change keyboard layout per application, to make all developer applications use
US layout and the rest SE layout. See: [Hyprland-per-window-layout](https://lib.rs/crates/hyprland-per-window-layout)

`cargo install hyperland-per-window-layout`

## Install Nix

### Install Nix Packagemanager

I use Determinate Nix for easy install: `https://docs.determinate.systems/`

```sh Install Nix Determinate for SELinux
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix|\
sh -s -- install --determinate
```

### Install Home Manager

This site has great info on creating a flake for home-manager

`https://www.chrisportela.com/posts/home-manager-flake/`

```sh
`nix build .#homeConfiguration."jesper".activationPackage` # Should be run first time, when building the Home manager result
`./result/activate` # will activate that build
`home-manager {build|switch} --flake .` # should be used when result is activated, easier to type, will be the same command in the background
```

```sh Install Home-manager (Depricated by Determinate, should now use flake instead)
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

### Set zsh as default shell

```sh Add zsh to list and set as default
echo /home/$USER/.nix-profile/bin/zsh | sudo tee -a /etc/shells
sudo usermod -s /home/$USER/.nix-profile/bin/zsh $USER
```

And then logout and back in

## Install Dev Env

### 1password

```sh
sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
sudo dnf install 1password
```

This is for getting flatpak versions of browsers to sync with the installed version,
works with firefox. This is used by chmod +x on the script and runnning it.

```sh
git clone https://github.com/FlyinPancake/1password-flatpak-browser-integration.git
```

### ClipSync, to sync xwayland and wayland copying

```sh
git clone https://github.com/alexankitty/clipsync.git
cd clipsync
./install.sh
```

This is then exec-once'd in Hyprland.conf

### Intellij

Download the .tar.gz file from `https://www.jetbrains.com/idea/download/`
`sudo tar -xzf ideaIU-*.tar.gz -C /opt`
`./opt/bin/{path}/idea.sh`


Toolbox
installed desktopfiles end up in `~/.local/share/applications/toolbox.desktop`



### Teams

```sh
wget -q -O - https://api.github.com/repos/IsmaelMartinez/teams-for-linux/releases/latest | grep 'rpm"$' | grep -v 'aarch' | grep -v 'armv7' | awk -F'"' '{print $4}' | wget -i -
```

```sh
sudo dnf install ./teams-for-linux
```

### Obsidian

```sh
flatpak install flathub md.obsidian.Obsidian
flatpak override --user --socket=wayland md.obsidian.Obsidian
```

Or install AppImage, downloading the image, filter out arm64 version (the -v) flag (to make git plugin work)

```sh
wget -q -O - https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep 'AppImage"$' | grep -v 'arm64' | awk -F'"' '{print $4}' | wget -i -
./~/git/fedora-home-manager/scripts/appimage-desktop-entry.sh Obsidian*
```

### Outlook-for-linux

For appimage:

```sh
wget -q -O - https://api.github.com/repos/mahmoudbahaa/outlook-for-linux/releases/latest | grep 'AppImage"$' | grep -v 'arm64' | grep -v 'armv7' | awk -F'"' '{print $4}'
```

For rpm package:

```sh
wget -q -O - https://api.github.com/repos/mahmoudbahaa/outlook-for-linux/releases/latest | grep 'rpm"$' | grep -v 'aarch' | grep -v 'armv7' | awk -F'"' '{print $4}' | wget -i -
```

```sh
sudo dnf install ./outlook-for-linux
```

### SSH Keygen for Github and DevOps

```url
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
```

### Azure CLI

```sh
az install bicep
```

### Global protect

Go to this page and get the rpm file:
`https://services.northwestern.edu/TDClient/30/Portal/KB/ArticleDet?ID=1420`


### Hyprland Polkit

To get a graphical polycykit authentication agent to work in hyprland, follow this guide: 
`https://elvinguti.dev/posts/fix-missing-polkit/`

The exec-once is already added in my hyprland config file.
