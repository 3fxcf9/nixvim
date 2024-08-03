{
  plugins.illuminate = {
    enable = true;
    underCursor = false;
    providers = [ "lsp" "treesitter" "regex" ];
    filetypesDenylist = [ "Outline" "TelescopePrompt" "alpha" ];
  };
}
