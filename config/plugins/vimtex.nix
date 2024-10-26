{
  pkgs,
  custom-latex-course-class,
  ...
}: {
  plugins.vimtex = {
    enable = true;
    settings = {
      view_method = "zathura";
      syntax_enabled = false;
      syntax_conceal_disable = true;
    };
    texlivePackage = pkgs.texlive.combine {
      inherit (pkgs.texlive) scheme-full;
      custom-latex-course-class = {
        pkgs = [
          custom-latex-course-class.packages.${pkgs.system}.default
        ];
      };
    };
  };
  autoCmd = [
    {
      command = "syn off";
      event = [
        "BufEnter"
      ];
      pattern = [
        "*.tex"
      ];
    }
  ];
}
