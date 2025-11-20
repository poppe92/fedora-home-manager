{
  pkgs,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    userEmail = "jesper.nilsson@omegapoint.se";
    userName = "Jesper N";

    extraConfig = {
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      init = {
        defaultBranch ="main";
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
      status = {
        relativePaths = false;
      };
    };

    delta = {
      enable = true;
      options = {
        whitespace-error-style = "22 reverse";
        side-by-side = true;
        navigate = true;
        line-numbers = true;
      };
    };

  };
}
