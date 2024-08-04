{
  plugins = {
    lsp-lines = {enable = true;};
    lsp-format = {enable = true;};
    lsp = {
      enable = true;
      servers = {
        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        tsserver.enable = true;
        emmet-ls.enable = true;
        html.enable = true;
        cssls.enable = true;

        lua-ls.enable = true;
        nil-ls.enable = true;

        marksman.enable = true;
        pyright.enable = true;

        jsonls.enable = true;
        yamlls.enable = true;

        bashls.enable = true;
      };

      keymaps = {
        silent = true;
        lspBuf = {
          "<leader>ld" = {
            action = "definition";
            desc = "Goto Definition";
          };
          "<leader>lR" = {
            action = "references";
            desc = "Goto References";
          };
          "<leader>lD" = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          "<leader>lI" = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          "<leader>lT" = {
            action = "type_definition";
            desc = "Type Definition";
          };
          "<leader>lh" = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>lr" = {
            action = "rename";
            desc = "Rename";
          };
        };
        diagnostic = {
          "<leader>ld" = {
            action = "open_float";
            desc = "Line Diagnostics";
          };
          "[d" = {
            action = "goto_next";
            desc = "Next Diagnostic";
          };
          "]d" = {
            action = "goto_prev";
            desc = "Previous Diagnostic";
          };
        };
      };
    };
  };
  extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config{
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }
  '';
}
