{
    plugins.flash = {
      enable = true;
      settings = {
        labels = "nesartiuflpmodc-hxgz,qykwjv.b";
        # modes.search.enabled = true;
      };
    };

    keymaps = [
      {
        key = "m";
        action = ''<cmd>lua require("flash").jump()<cr>'';
        options.desc = "Flash jump";
      }
    ];
}
