{
  plugins = {
    lsp-lines = {enable = true;};
    lsp-format = {enable = true;};
    lsp = {
      enable = true;
      servers = {
        texlab = {
          enable = true;
          settings = {
            texlab = {
              build = {
                args = [
                  "-pdflatex"
                  "-outdir=.build"
                  "-verbose"
                  "-file-line-error"
                  "-synctex=1"
                  "-interaction=nonstopmode"
                  "%f"
                ];
                executable = "latexmk";
                onSave = true;
                forwardSearchAfter = false;
              };
              chktex = {
                onEdit = true;
                onOpenAndSave = true;
              };
              diagnosticsDelay = 100;
              # diagnostics = {
              #   ignoredPatterns = [".*may.*"];
              # };
              forwardSearch = {
                executable = "zathura";
                args = ["--synctex-forward" "%l:1:%f" "%p"];
              };
              latexFormatter = "latexindent";
            };
          };
        };
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        ts_ls.enable = true;
        emmet_ls.enable = true;
        html.enable = true;
        cssls.enable = true;

        lua_ls.enable = true;
        nil_ls.enable = true;

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
