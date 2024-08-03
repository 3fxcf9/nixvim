{
  lib,
  pkgs,
  ...
}: {
  extraConfigLuaPre =
    # lua
    ''
      local slow_format_filetypes = {}

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
    formatOnSave =
      # lua
      ''
        function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          if slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end

          return { timeout_ms = 200, lsp_fallback = true }
         end
      '';

    formatAfterSave =
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

    notifyOnError = true;
    formattersByFt = {
      html = ["prettierd"];
      css = ["prettierd"];
      javascript = ["prettierd"];
      typescript = ["prettierd"];
      python = ["black" "isort"];
      lua = ["stylua"];
      nix = ["alejandra"];
      markdown = ["prettierd" "cbfmt"];
      yaml = ["prettierd"];
      bash = ["shellcheck" "shellharden" "shfmt"];
      json = ["jq"];
      "_" = ["trim_whitespace"];
    };

    formatters = {
      black = {command = "${lib.getExe pkgs.black}";};
      isort = {command = "${lib.getExe pkgs.isort}";};
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
}
