{ 
  pkgs,
  ... 
}: {

  programs.zsh = {
	enable = true;
	shellAliases = {
		ls = "eza --icons=auto --color=auto";
		lst = "eza --tree --icons=auto --color=auto";
		ll = "eza -lah --icons=auto --color=auto";
		cat = "bat --theme Dracula";
		whatsmypublicip = "curl -4L myip.0xa.se";
		vim = "nvim";
		nvim-tc = "NVIM_APPNAME=\"nvim-typecraft\" nvim";
		# idea = "${pkgs.jetbrains.idea-ultimate}/idea-ultimate/bin/idea.sh \"$1\" > /dev/null 2>&1 &";
	};
	oh-my-zsh = {
		enable = true;
		theme = "af-magic";
		plugins = ["git" "mvn" "fzf" ];
	};
	syntaxHighlighting.enable = true;
        autosuggestion = {
		enable = true;
		strategy = [ "history" "completion" ];
	};
	initContent = ''
		#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
		export SDKMAN_DIR="$HOME/.sdkman"
		[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

		export PATH="$HOME/.local/bin:$PATH"

		# ---------------------
		# eza universal Dracula
		# ---------------------
		export EZA_COLORS="\
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
		xx=95:"

		bindkey '^ ' autosuggest-accept

		fortune | cowsay | lolcat
	'';
  };

}
