{
  plugins.alpha = {
    enable = true;
    layout = [
      {
        type = "padding";
        val = 8;
      }
      {
        opts = {
          hl = "Constant";
          position = "center";
        };
        type = "text";
        val = [
          " ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓"
          " ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒"
          "▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░"
          "▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██"
          "▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒"
          "░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░░"
          "░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░"
          "   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░"
          "         ░    ░  ░    ░ ░        ░   ░         ░"
          "                                ░"
        ];
      }
      {
        type = "padding";
        val = 2;
      }
      {
        type = "group";
        opts.spacing = 1;
        val = let
          mkButton = shortcut: cmd: val: hl: {
            type = "button";
            inherit val;
            opts = {
              inherit hl shortcut;
              keymap = [
                "n"
                shortcut
                cmd
                {
                  noremap = true;
                  silent = true;
                  nowait = true;
                }
              ];
              position = "center";
              cursor = 3;
              width = 50;
              align_shortcut = "right";
              hl_shortcut = "@variable.builtin";
            };
          };
        in [
          (
            mkButton
            "e"
            "<CMD>ene<CR>"
            "  New file"
            "AlphaButtons"
          )
          (
            mkButton
            "f"
            "<CMD>Telescope find_files<CR>"
            "󰭎  Find file"
            "AlphaButtons"
          )

          (
            mkButton
            "r"
            "<CMD>Telescope oldfiles<CR>"
            "  Recently edited"
            "AlphaButtons"
          )

          (
            mkButton
            "g"
            "<CMD>Telescope live_grep<CR>"
            "󰱽  Find text"
            "AlphaButtons"
          )
          (
            mkButton
            "q"
            "<CMD>qa<CR>"
            "󰩈  Quit Neovim"
            "@variable.builtin"
          )
        ];
      }
      {
        type = "padding";
        val = 2;
      }
      {
        opts = {
          hl = "@comment";
          position = "center";
        };
        type = "text";
        val = "https://github.com/3fxcf9/nixvim";
      }
    ];
  };
}
