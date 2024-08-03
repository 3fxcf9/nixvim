{
  opts.completeopt = ["menu" "menuone" "noinsert"];
  plugins = {
    luasnip.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-nvim-lsp-document-symbol.enable = true;
    cmp-nvim-lsp-signature-help.enable = true;
    cmp-path.enable = true;

    cmp-buffer.enable = true;
    cmp_luasnip.enable = true;
    friendly-snippets.enable = true;

    cmp = {
      enable = true;
      settings = {
        autoEnableSources = true;
        experimental = {ghost_text = true;};

        completion.completeopt = "menu,menuone,noinsert";

        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        sources = [
          {name = "luasnip";}
          {name = "nvim_lsp";}
          {name = "nvim_lsp_document_symbol";}
          {name = "nvim_lsp_signature_help";}
          {name = "treesitter";}
          {name = "path";}
          {name = "calc";}
          {name = "git";}
          {name = "nvim_lua";}
        ];

        window = {
          completion.__raw =
            # lua
            ''cmp.config.window.bordered()'';
          documentation.__raw =
            # lua
            ''cmp.config.window.bordered()'';
        };

        mapping = {
          "<C-t>" = ''
            function(fallback)
              local line = vim.api.nvim_get_current_line()
              if line:match("^%s*$") then
                fallback()
              elseif cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
              else
                fallback()
              end
            end
          '';
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
        };
      };

      cmdline = {
        "/" = {
          mapping = {
            __raw = "cmp.mapping.preset.cmdline()";
          };
          sources = [
            {
              name = "buffer";
            }
          ];
        };
        ":" = {
          mapping = {
            __raw = "cmp.mapping.preset.cmdline()";
          };
          sources = [
            {
              name = "path";
            }
            {
              name = "cmdline";
              option = {
                ignore_cmds = [
                  "Man"
                  "!"
                ];
              };
            }
          ];
        };
      };
    };
    lspkind = {
      enable = true;

      cmp = {
        enable = true;

        menu = {
          buffer = "";
          calc = "";
          cmdline = "";
          emoji = "󰞅";
          git = "";
          luasnip = "󰩫";
          nvim_lsp = "";
          nvim_lua = "";
          path = "";
          spell = "";
          treesitter = "󰔱";
        };
      };
    };
  };
  keymaps = [
    {
      mode = ["i" "n" "v"];
      key = "<C-e>";
      action = ''<cmd>lua require('luasnip').jump(1)<cr>'';
      options = {
        # remap = true;
        desc = "Luasnip jump forward";
      };
    }
    {
      mode = ["i" "n" "v"];
      key = "<C-s>";
      action = ''<cmd>lua require('luasnip').jump(-1)<cr>'';
      options.desc = "Luasnip jump backward";
    }
  ];
}
