{ 
  pkgs,
  ... 
}: {
	programs.eza = {
		enable = true;
		colors = "always";
		icons = "always";
		git = true;
		enableZshIntegration = true;
	};
}
