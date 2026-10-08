{ 
  pkgs,
  desktopShell,
  ... 
}: {

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "eza --sort newest --icons=auto --color=auto";
      lst = "eza --tree --icons=auto --color=auto";
      ll = "eza -lah --sort newest --icons=auto --color=auto";
      cat = "bat --theme Dracula";
      whatsmypublicip = "curl -4L myip.0xa.se";
      vim = "nvim";
      nvim-tc = "NVIM_APPNAME=\"nvim-typecraft\" nvim";
      recursiveDiskUsage = "du -aBM 2>/dev/null | sort -nr | head -n 50 | more";
      idea = "~/.local/share/JetBrains/Toolbox/apps/intellij-idea-ultimate/bin/idea";
      nfsResetDbDocker = "docker compose --file $HOME/FRAC/code/fleet-management/nfs-service/nfs-service/docker-compose.yml up -d && docker compose --file $HOME/FRAC/code/fleet-management/nfs-service/nfs-service/docker-compose.yml down && docker volume rm nfs-service-postgres-data && docker compose --file $HOME/FRAC/code/fleet-management/nfs-service/nfs-service/docker-compose.yml up -d";
      autosyncResetDbDocker = "docker compose --file $HOME/FRAC/code/fleet-management/autosync-integration/docker-compose.yml up -d && docker compose --file $HOME/FRAC/code/fleet-management/autosync-integration/docker-compose.yml down --volumes && docker compose --file $HOME/FRAC/code/fleet-management/autosync-integration/docker-compose.yml up -d";
      nfsStartLocal = "docker compose --file $HOME/FRAC/code/fleet-management/nfs-service/nfs-service/docker-compose.yml up -d && cd $HOME/FRAC/code/fleet-management/nfs-service && mvn quarkus:dev -pl nfs-service -Dquarkus.profile=local";
      autosyncStartLocal = "docker compose --file $HOME/FRAC/code/fleet-management/autosync-integration/docker-compose.yml up -d && cd $HOME/FRAC/code/fleet-management/autosync-integration && mvn spring-boot:run -Dspring-boot.run.profiles=localhost -Dspring-boot.run.jvmArguments=\"-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005\"";
      damageResetDocker = "docker compose --file $HOME/FRAC/code/fleet-management/damage-handling-service/docker-compose.yml up -d && docker compose --file $HOME/FRAC/code/fleet-management/damage-handling-service/docker-compose.yml down --volumes && docker compose --file $HOME/FRAC/code/fleet-management/damage-handling-service/docker-compose.yml up -d";
      damageStartLocal = "docker compose --file $HOME/FRAC/code/fleet-management/damage-handling-service/docker-compose.yml up -d && cd $HOME/FRAC/code/fleet-management/damage-handling-service && mvn quarkus:dev";
    };
    oh-my-zsh = {
      enable = true;
      theme = if desktopShell == "noctalia" then "" else "af-magic";
      plugins = ["git" "mvn" "fzf" ];
    };
    syntaxHighlighting.enable = true;
      autosuggestion = {
      enable = true;
      strategy = [ "history" "completion" ];
    };
    initContent = ''
      export PATH="$HOME/.local/bin:$PATH"

      # The Noctalia profile uses Ghostty's Eldritch ANSI palette. Legacy retains
      # its current Dracula-oriented category mapping.
      export EZA_COLORS="${if desktopShell == "noctalia" then ''\
        uu=36:\
        uR=31:\
        un=35:\
        gu=37:\
        da=2;34:\
        ur=34:\
        uw=95:\
        ux=32:\
        ue=32:\
        gr=34:\
        gw=35:\
        gx=36:\
        tr=34:\
        tw=35:\
        tx=36:\
        xx=95:'' else ''\
        uu=36:\
        uR=31:\
        un=35:\
        gu=37:\
        da=2;34:\
        ur=34:\
        uw=95:\
        ux=36:\
        ue=36:\
        gr=34:\
        gw=35:\
        gx=36:\
        tr=34:\
        tw=35:\
        tx=36:\
        xx=95:''}"

      bindkey '^ ' autosuggest-accept

      source /home/jesper/FRAC/code/tooling-environment/developer-utils/sh-source/tools.sh

      if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi

      fortune | cowsay | lolcat
    '';
  };

  programs.starship = {
    enable = desktopShell == "noctalia";
    enableZshIntegration = true;
  };

}
