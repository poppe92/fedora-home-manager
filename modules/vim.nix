{
  pkgs,
  config,
  ...
}: {

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ 
      vim-airline 
      dracula-vim
    ];
    settings = { 
      ignorecase = true; 
    };
    extraConfig = ''
        colorscheme dracula
		nnoremap t o<ESC>k
		nnoremap T O<ESC>j

		imap jk <ESC>

		nmap k gk
		nmap j gj
		
		set colorcolumn=90
		set clipboard=unnamedplus
		set nowrap
		set tabstop=4
		set shiftwidth=4
		set smartindent
		set ignorecase
		set smartcase

		set relativenumber
		set encoding=utf-8
    '';
  };

}
