{
  pkgs,
  anki-nvim,
  ...
}: {
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "anki-nvim";
      src = anki-nvim;
    })
  ];

  extraConfigLua = ''
    require("anki").setup({
      tex_support = true,
      models = {
        Basic = "SUP::To sort",
      },
    })
  '';
}
