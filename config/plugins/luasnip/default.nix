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
  };
  keymaps = [
    {
      mode = ["i" "n" "v"];
      key = "<C-n>";
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
