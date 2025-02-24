{
  plugins.gitsigns = {
    enable = true;
    settings.current_line_blame = true;
  };
  keymaps = [
    {
      mode = ["n"];
      key = "<leader>ub";
      action = ''<cmd>lua require("gitsigns.actions").toggle_current_line_blame()<cr>'';
      options = {
        remap = true;
        desc = "Toggle line blame";
      };
    }
  ];

  highlight.GitSignsCurrentLineBlame = {
    link = "Comment";
    italic = true;
  };
}
