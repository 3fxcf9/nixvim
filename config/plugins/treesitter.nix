{pkgs, ...}: {
  plugins = {
    treesitter = {
      enable = true;
      settings = {
        auto_install = false;
        ensure_installed = [
          "git_config"
          "git_rebase"
          "gitattributes"
          "gitcommit"
          "gitignore"
          "v"
        ];
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = true;
        };
        indent.enable = true;
      };
      folding = false;
      nixvimInjections = true;
      # grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        json
        yaml
        lua
        make
        markdown
        nix
        regex
        toml
        vim
        vimdoc
        rust
        html
        css
        javascript
      ];
    };

    treesitter-textobjects = {
      enable = false;
      select = {
        enable = true;
        lookahead = true;
        keymaps = {
          "aa" = "@parameter.outer";
          "ia" = "@parameter.inner";
          "af" = "@function.outer";
          "if" = "@function.inner";
          "ac" = "@class.outer";
          "ic" = "@class.inner";
          "ii" = "@conditional.inner";
          "ai" = "@conditional.outer";
          "il" = "@loop.inner";
          "al" = "@loop.outer";
          "at" = "@comment.outer";
        };
      };
      move = {
        # TODO: Change keybindings
        enable = true;
        gotoNextStart = {
          "]m" = "@function.outer";
          "]]" = "@class.outer";
        };
        gotoNextEnd = {
          "]M" = "@function.outer";
          "][" = "@class.outer";
        };
        gotoPreviousStart = {
          "[m" = "@function.outer";
          "[[" = "@class.outer";
        };
        gotoPreviousEnd = {
          "[M" = "@function.outer";
          "[]" = "@class.outer";
        };
      };
      swap = {
        enable = true;
        swapNext = {"<leader>a" = "@parameters.inner";};
        swapPrevious = {"<leader>A" = "@parameter.outer";};
      };
    };
  };
}
