{pkgs, ...}: {
  extraPlugins = [pkgs.vimPlugins.substitute-nvim];

  extraConfigLua = ''
    require("substitute").setup({})
  '';

  keymaps = [
    {
      mode = "n";
      key = "s";
      action.__raw = ''require("substitute").operator'';
      options.noremap = true;
    }
    {
      mode = "n";
      key = "ss";
      action.__raw = ''require("substitute").line'';
      options.noremap = true;
    }
    {
      mode = "n";
      key = "S";
      action.__raw = ''require("substitute").eol'';
      options.noremap = true;
    }
    {
      mode = "x";
      key = "s";
      action.__raw = ''require("substitute").visual'';
      options.noremap = true;
    }
  ];
}
