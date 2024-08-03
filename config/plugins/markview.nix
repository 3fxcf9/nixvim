{pkgs, ...}: {
  extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin rec {
      pname = "markview.nvim";
      version = "1.0.0";
      src = pkgs.fetchFromGitHub {
        owner = "OXY2DEV";
        repo = "markview.nvim";
        rev = "refs/tags/v${version}";
        hash = "sha256-mhRg/cszW/3oXdC1yvbpCeqWQA9WLW5FvcqGd/wBTnE=";
      };
    })
  ];

  extraConfigLua = ''
      require("markview").setup({
        ["links.enable"] = true,
        ["inline_codes.enable"] = true,
        code_blocks = {
          enable = true,
          style = "language",
          position = "overlay",

          min_width = 70,
          pad_char = " ",
          pad_amount = 2,

          hl = "markdownCodeBlock",
          language_direction = "right",

          sign = true,
          sign_hl = nil
        },
        tables = {
          enable = true,
          use_virt_lines = false,

          text = {
              "╭", "─", "╮", "┬",
              "├", "│", "┤", "┼",
              "╰", "─", "╯", "┴",

              -- These are used to indicate text alignment
              -- The last 2 are used for "center" alignment
              "╼", "╾", "╴", "╶"
          },

          hl = {
              "rainbow1", "rainbow1", "rainbow1", "rainbow1",
              "rainbow1", "rainbow1", "rainbow1", "rainbow1",
              "rainbow1", "rainbow1", "rainbow1", "rainbow1",

              "rainbow1", "rainbow1", "rainbow1", "rainbow1"
          }
        }
    })
  '';
}
