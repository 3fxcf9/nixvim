{
  colorschemes.tokyonight = {
    enable = true;
    settings = {
      style = "night";
      transparent = true;
      dim_inactive = true;
      hide_inactive_statusline = true;
      on_highlights = ''
        function(hl, c)
          hl.FloatBorder.fg = c.blue
          hl.WinSeparator.fg = c.fg_gutter
          hl.NvimTreeWinSeparator.fg = c.fg_gutter
          hl.IlluminatedWordText.bg = c.fg_gutter
          hl.IlluminatedWordRead.bg = c.fg_gutter
          hl.IlluminatedWordWrite.bg = c.fg_gutter
          end
      '';
      lualine_bold = true;
      styles = {
        comments.italic = true;
        keywords.italic = true;
        floats = "transparent";
        sidebars = "transparent";
      };
    };
  };

  highlightOverride = {
    LspInlayHint = {
      bg = "NONE";
      link = "Comment";
    };
    NvimTreeSpecialFile = {
      bold = true;
    };
  };

  # Highlight and remove extra white spaces
  highlight.ExtraWhitespace.bg = "#f7768e";
  match.ExtraWhitespace = "\\s\\+$";
}
/*
   hl.TelescopeNormal = {
    bg = c.bg_dark,
    fg = c.fg_dark,
}
hl.TelescopeBorder = {
    bg = c.bg_dark,
    fg = c.bg_dark,
}
hl.TelescopePromptNormal = {
    bg = prompt,
}
hl.TelescopePromptBorder = {
    bg = prompt,
    fg = prompt,
}
hl.TelescopePromptTitle = {
    bg = prompt,
    fg = prompt,
}
hl.TelescopePreviewTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
}
hl.TelescopeResultsTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
}
*/

