{
  pkgs,
  config,
  ...
}: {
  programs.git = {
    enable = true;

    settings = {
      user.email = "jesper.nilsson@omegapoint.se";
      user.name = "Jesper N";

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

  };
}
