{
  plugins.telescope = {
    enable = true;
    settings = {
      defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
        ];
        layout_config = {
          prompt_position = "top";
        };
        mappings = {
          i = {
            "<C-j>" = {
              __raw = "require('telescope.actions').move_selection_next";
            };
            "<C-k>" = {
              __raw = "require('telescope.actions').move_selection_previous";
            };
          };
        };
        selection_caret = "> ";
        set_env = {
          COLORTERM = "truecolor";
        };
        sorting_strategy = "ascending";
      };
    };
    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        options.desc = "Find files in cwd";
      };
      "<leader>fr" = {
        action = "oldfiles";
        options.desc = "Find recent files";
      };
      "<leader>fg" = {
        action = "live_grep";
        options.desc = "Find string in cwd";
      };
      "<leader>fc" = {
        action = "grep_string";
        options.desc = "Find string under cursor in cwd";
      };
    };
    extensions.fzf-native = {enable = true;};
  };
}
