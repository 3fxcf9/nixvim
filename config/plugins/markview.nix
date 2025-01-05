{pkgs, ...}: {
  plugins.markview = {
    enable = true;
    settings = {
      hybrid_modes = ["n"];
      links.enable = true;
      inline_codes.enable = true;
      code_blocks = {
        enable = true;
        style = "language";
        position = "overlay";

        min_width = 70;
        pad_char = " ";
        pad_amount = 2;

        hl = "markdownCodeBlock";
        language_direction = "right";

        sign = true;
        sign_hl = null;
      };
      tables = {
        enable = true;
        use_virt_lines = false;

        text = [
          "╭"
          "─"
          "╮"
          "┬"
          "├"
          "│"
          "┤"
          "┼"
          "╰"
          "─"
          "╯"
          "┴"

          # These are used to indicate text alignment
          "╼"
          "╾"
          # The last 2 are used for "center" alignment
          "╴"
          "╶"
        ];

        hl = [
          "rainbow1"
          "rainbow1"
          "rainbow1"
          "rainbow1"
          "rainbow1"
          "rainbow1"
          "rainbow1"
          "rainbow1"
          "rainbow1"
          "rainbow1"
          "rainbow1"
          "rainbow1"
          "rainbow1"
          "rainbow1"
          "rainbow1"
          "rainbow1"
        ];
      };
    };
  };
}
