{ 
  pkgs, 
  config, 
  ... 
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      nvim-lspconfig

      trouble-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      plenary-nvim
      fidget-nvim
      vim-nix # Nix Syntax highlightning

      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-cmdline
      cmp-path

      vim-sleuth # Automatic detection of tabs and spaces
      lspkind-nvim
      nvim-lint
      neoformat
      rainbow # Rainbow format of {}

      vim-surround
      mini-nvim # Better around/inside textobjects

      todo-comments-nvim

      neo-tree-nvim

      lazygit-nvim
      gitsigns-nvim # Adds git related signs to the gutter, as well as utilities for managing changes

      which-key-nvim # Useful plugin to show you pending keybinds.
    ];

    extraConfig = ''
      lua << EOF
      ${builtins.readFile config/keymaps.lua}
      ${builtins.readFile config/options.lua}
      ${builtins.readFile config/plugins/gitsigns.lua}
      ${builtins.readFile config/plugins/whichKey.lua}
    '';

      #${builtins.readFile config/plugins/telescope.lua}
  };
}

