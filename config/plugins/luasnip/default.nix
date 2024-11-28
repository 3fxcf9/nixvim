{
  plugins.luasnip = {
    enable = true;
    settings = {
      enable_autosnippets = true;
      store_selection_keys = "<Tab>";
      update_events = "TextChanged,TextChangedI";
    };
    fromLua = [
      {
        paths = ./snippets;
      }
    ];
    filetypeExtend = {
      markdown = [
        "latex"
        "tex"
      ];
    };
  };
  keymaps = [
    {
      mode = ["i" "n" "v"];
      key = "<C-b>";
      action = ''<cmd>lua require('luasnip').expand()<cr>'';
      options = {
        remap = true;
        desc = "Luasnip expand";
      };
    }
    {
      mode = ["i" "n" "v"];
      key = "<C-t>";
      action = ''<cmd>lua require('luasnip').jump(1)<cr>'';
      options = {
        remap = true;
        desc = "Luasnip jump forward";
      };
    }
    {
      mode = ["i" "n" "v"];
      key = "<C-e>";
      action = ''<cmd>lua require('luasnip').jump(-1)<cr>'';
      options.desc = "Luasnip jump backward";
    }
  ];
}
