{pkgs, ...}: {
  plugins.vimtex = {
    enable = true;
    settings.view_method = "zathura";
    texlivePackage = pkgs.texlive.combined.scheme-full;
  };
}
