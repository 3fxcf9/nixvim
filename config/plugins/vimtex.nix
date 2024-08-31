{...}: {
  plugins.vimtex = {
    enable = true;
    settings = {
      compiler_method = "latexmk";
      view_method = "zathura";
    };
  };
}
