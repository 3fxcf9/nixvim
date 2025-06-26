{
  imports = [
    # General
    ./options.nix
    ./keymaps.nix
    ./autocommands.nix

    # Theme
    ./colorscheme.nix

    # Completion
    ./plugins/cmp/cmp.nix
    ./plugins/luasnip

    # LSP
    ./plugins/lsp/lsp.nix
    ./plugins/lsp/figdet.nix
    ./plugins/lsp/conform.nix
    ./plugins/lsp/trouble.nix
    ./plugins/lsp/barbecue.nix

    # Ui
    ./plugins/ui/alpha.nix
    ./plugins/ui/dressing.nix
    ./plugins/ui/indent-blankline.nix
    ./plugins/ui/lualine.nix
    ./plugins/ui/nvim-tree.nix
    ./plugins/ui/which-key.nix
    ./plugins/ui/zen-mode.nix
    ./plugins/ui/telescope.nix
    ./plugins/ui/toggleterm.nix
    # ./plugins/ui/notify.nix

    # Git
    ./plugins/git/gitsigns.nix

    ./plugins/treesitter.nix
    ./plugins/illuminate.nix
    ./plugins/colorizer.nix
    ./plugins/comment.nix
    ./plugins/nvim-surround.nix
    ./plugins/todo-comments.nix
    # ./plugins/markview.nix
    ./plugins/vimtex.nix
    # ./plugins/hardtime.nix
    ./plugins/precognition.nix
    ./plugins/web-devicons.nix
    ./plugins/autopairs.nix
    ./plugins/substitute.nix
    # ./plugins/anki.nix
  ];
  luaLoader.enable = true;
}
