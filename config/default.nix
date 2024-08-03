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

    # LSP
    ./plugins/lsp/lsp.nix
    ./plugins/lsp/figdet.nix
    ./plugins/lsp/conform.nix
    ./plugins/lsp/trouble.nix

    # Ui
    ./plugins/ui/alpha.nix
    ./plugins/ui/dressing.nix
    ./plugins/ui/indent-blankline.nix
    ./plugins/ui/lualine.nix
    ./plugins/ui/nvim-tree.nix
    ./plugins/ui/which-key.nix
    ./plugins/ui/zen-mode.nix
    ./plugins/ui/telescope.nix

    # Git
    ./plugins/git/gitsigns.nix

    ./plugins/treesitter.nix
    ./plugins/flash.nix
    ./plugins/illuminate.nix
    ./plugins/colorizer.nix
    ./plugins/comment.nix
    ./plugins/autopairs.nix
    ./plugins/todo-comments.nix
    ./plugins/markview.nix
  ];
  luaLoader.enable = true;

  # Highlight and remove extra white spaces
  highlight.ExtraWhitespace.bg = "#f7768e";
  match.ExtraWhitespace = "\\s\\+$";
}
