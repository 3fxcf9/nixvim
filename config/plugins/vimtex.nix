{
  pkgs,
  custom-latex-course-class,
  ...
}: {
  plugins.vimtex = {
    enable = true;
    settings = {
      view_method = "zathura";
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
      command = "set conceallevel=1";
      event = [
        "BufEnter"
      ];
      pattern = [
        "*.tex"
      ];
    }
  ];
}
