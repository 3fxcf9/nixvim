{
  plugins.twilight.enable = true;
  plugins.zen-mode = {
    enable = true;
    settings = {
      on_open = ''
        function()
          require("gitsigns.actions").toggle_current_line_blame()
          vim.opt.relativenumber = false
          vim.opt.signcolumn = "no"
          vim.opt.wrap = true
          vim.opt.linebreak = true
        end
      '';
      plugins = {
        gitsigns = {enabled = true;};
        options = {
          enabled = true;
          ruler = false;
          showcmd = false;
        };
        tmux = {enabled = true;};
      };
      window = {
        backdrop = 0.95;
        height = 1;
        options = {signcolumn = "no";};
        width = 0.9;
      };
    };
  };
}
