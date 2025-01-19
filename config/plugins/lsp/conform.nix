{
  lib,
  pkgs,
  ...
}: {
  extraConfigLuaPre =
    # lua
    ''
      local slow_format_filetypes = {
        latex = true,
        tex = true,
        python = true
      }

      vim.api.nvim_create_user_command("FormatDisable", function(args)
         if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    '';

  plugins.conform-nvim = {
    enable = true;
    settings = {
      notify_on_error = true;
      format_on_save =
        # lua
        ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            if slow_format_filetypes[vim.bo[bufnr].filetype] then
              return
            end

            return { timeout_ms = 500, lsp_fallback = true }
           end
        '';

      format_after_save =
        # lua
        ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            if not slow_format_filetypes[vim.bo[bufnr].filetype] then
              return
            end

            return { lsp_fallback = true }
          end
        '';
      formatters_by_ft = {
        html = ["prettierd"];
        css = ["prettierd"];
        javascript = ["prettierd"];
        typescript = ["prettierd"];
        python = ["black" "isort"];
        lua = ["stylua"];
        nix = ["alejandra"];
        # markdown = ["prettierd" "cbfmt"];
        markdown = ["prettierd"];
        yaml = ["prettierd"];
        bash = ["shellcheck" "shellharden" "shfmt"];
        json = ["jq"];
        rust = ["rustfmt"];
        tex = ["latexindent"];
        "_" = ["trim_whitespace"];
      };

      # TODO: Remove ASAP (install in shells instead)
      formatters = {
        latexindent = {prepend_args = ["-l" "-g" "/dev/null"];}; # Disable output to a log file
        alejandra = {command = "${lib.getExe pkgs.alejandra}";};
        jq = {command = "${lib.getExe pkgs.jq}";};
        prettierd = {command = "${lib.getExe pkgs.prettierd}";};
        stylua = {command = "${lib.getExe pkgs.stylua}";};
        shellcheck = {command = "${lib.getExe pkgs.shellcheck}";};
        shfmt = {command = "${lib.getExe pkgs.shfmt}";};
        shellharden = {command = "${lib.getExe pkgs.shellharden}";};
        cbfmt = {command = "${lib.getExe pkgs.cbfmt}";};
      };
    };
  };
}
