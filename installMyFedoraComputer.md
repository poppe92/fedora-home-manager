# Setup Work computer on Linux

## Install Fedora Workstation (or Ubuntu if Microsoft Intune Works there)

### Install Microsoft Intune for managing computer

### Fix Sound 9i Pro

```url
https://github.com/maximmaxim345/yoga_pro_9i_gen9_linux
```

### Install common packages

```sh
mkdir ~/git
sudo dnf install thunderbird swaylock timeshift hyprlock golang hyprshot evolution evolution-ews desktop-file-utils
sudo dnf install dotnet-sdk-8.0
sudo dnf copr enable yuezk/globalprotect-openconnect
sudo dnf copr enable skidnik/clipmenu
sudo dnf install clipmenu
sudo dnf install globalprotect-openconnect
flatpak install com.usebruno.Bruno 
systemctl --user enable --now clipmenud
```

Timeshift is for rollback possiblities, create backup after signing Nvidia drivers

```sh
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install code
```

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

## Install Nix

### Install Nix Packagemanager

```sh Install Nix Determinate for SELinux
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix|\
sh -s -- install --determinate
```

### Install Home Manager

```sh Install Home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

```sh
nix-shell '<home-manager>' -A install
```

```sh
home-manager build -f home.nix
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

### Slack

```sh
flatpak install slack
```

### Teams

```sh
curl -1sLf -o /tmp/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc
sudo rpm --import /tmp/teams-for-linux.asc
rm -f /tmp/teams-for-linux.asc
sudo curl -1sLf -o /etc/yum.repos.d/teams-for-linux.repo https://repo.teamsforlinux.de/rpm/teams-for-linux.repo
sudo yum update && sudo yum install teams-for-linux
```

### Obsidian

```sh
flatpak install flathub md.obsidian.Obsidian
flatpak override --user --socket=wayland md.obsidian.Obsidian
```

Or install AppImage, downloading the image, filter out arm64 version (the -v) flag (to make git plugin work)

```sh
wget -q -O - https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep 'AppImage"$' | grep -v 'arm64' | awk -F'"' '{print $4}' | wget -i -
```

### Outlook-for-linux

```sh
wget -q -O - https://api.github.com/repos/mahmoudbahaa/outlook-for-linux/releases/latest | grep 'AppImage"$' | grep -v 'arm64' | grep -v 'armv7' | awk -F'"' '{print $4}'
```

### SSH Keygen for Github and DevOps

```url
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
```

### Azure CLI

```sh
az install bicep
```
