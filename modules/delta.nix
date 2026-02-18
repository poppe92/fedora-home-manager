
{
  pkgs,
  config,
  ...
}: {

  delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      whitespace-error-style = "22 reverse";
      side-by-side = true;
      navigate = true;
      line-numbers = true;
    };
  };
}
