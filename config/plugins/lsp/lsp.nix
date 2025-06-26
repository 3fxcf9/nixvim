{pkgs, ...}: {
  plugins = {
    lsp-lines = {enable = true;};
    lsp-format = {enable = true;};
    lsp = {
      enable = true;
      servers = {
        texlab = {
          enable = false;
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

        # ocamllsp = {
        #   enable = true;
        #   package = pkgs.ocamlPackages.ocaml-lsp;
        # };
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
          "<leader>lx" = {
            action = "open_float";
            desc = "Line Diagnostics";
          };
          "[x" = {
            action = "goto_next";
            desc = "Next Diagnostic";
          };
          "]x" = {
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

  # # v-analyzer
  # extraConfigLuaPost = ''
  #   vim.api.nvim_create_autocmd("FileType", {
  #     pattern = "v",
  #     callback = function()
  #       vim.lsp.start({
  #         name = "v_analyzer",
  #         cmd = {"v-analyzer"},
  #         root_dir = vim.fs.find({".git"}, { upward = true, type = "directory" })[1] or vim.loop.cwd(),
  #       })
  #     end,
  #   })
  # '';

  keymaps = [
    {
      mode = ["n"];
      key = "<leader>lH";
      action = ''<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr })<cr>'';
      options = {
        remap = true;
        desc = "Toggle inlay hints";
      };
    }
  ];
}
