{
  pkgs,
  lib,
  ...
}: {
  clipboard = {
    # Use system clipboard
    register = "unnamedplus";

    providers = {
      wl-copy = {
        enable = true;
        package = pkgs.wl-clipboard;
      };
    };
  };
  opts = {
    updatetime = 50; # Faster completion

    number = true;
    relativenumber = true;

    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    softtabstop = 2;
    autoindent = true;
    smartindent = true;
    breakindent = true;
    copyindent = true;

    showmatch = true;
    matchtime = 1;

    wrap = true;
    scrolloff = 8;
    cursorline = true;

    termguicolors = true;

    ignorecase = true;
    incsearch = true;
    hlsearch = true;
    smartcase = true;
    backspace = "indent,eol,start";
    wildmode = "list:longest";
    signcolumn = "yes";
    mouse = "a";
    fileencoding = "utf-8";

    spelllang = lib.mkDefault ["en_us"]; # TODO: Bind config
    spell = false;

    # Window splits
    splitright = true;
    splitbelow = true;

    swapfile = false;
    undofile = true;
    conceallevel = 0;
  };
}
