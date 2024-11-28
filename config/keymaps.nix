{
  globals.mapleader = " ";
  globals.maplocalleader = ",";

  # extraConfigLua = ''vim.o.langmap = "rj,jr"'';

  keymaps = [
    # Navigate between the two most recent buffers
    {
      key = "<leader>bb";
      action = ":b#<CR>";
      options.desc = "Switch to most recent buffer";
    }

    # o O but for normal mode
    {
      key = "<leader>o";
      action = "o<ESC>";
      options.desc = "Append line below cursor";
    }
    {
      key = "<leader>O";
      action = "O<ESC>";
      options.desc = "Append line above the cursor";
    }

    # Spelling
    {
      mode = "n";
      key = "<leader>uS";
      action = "<cmd>set nospell<cr>";
      options.desc = "Disable spelling";
    }
    {
      mode = "n";
      key = "<leader>us";
      action = "<cmd>set spell<cr>";
      options.desc = "Enable spelling";
    }

    # Better up/down motion (line wrap)
    {
      mode = ["n" "x"];
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        expr = true;
        silent = true;
      };
    }
    {
      mode = ["n" "x"];
      key = "<Down>";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        expr = true;
        silent = true;
      };
    }
    {
      mode = ["n" "x"];
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        expr = true;
        silent = true;
      };
    }
    {
      mode = ["n" "x"];
      key = "<Up>";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        expr = true;
        silent = true;
      };
    }

    # Window motion
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options = {
        desc = "Go to Left Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options = {
        desc = "Go to Lower Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options = {
        desc = "Go to Upper Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options = {
        desc = "Go to Right Window";
        remap = true;
      };
    }
    {
      mode = "t";
      key = "<C-h>";
      action = "<cmd>wincmd h<cr>";
      options.desc = "Go to Left Window";
    }
    {
      mode = "t";
      key = "<C-j>";
      action = "<cmd>wincmd j<cr>";
      options.desc = "Go to Lower Window";
    }
    {
      mode = "t";
      key = "<C-k>";
      action = "<cmd>wincmd k<cr>";
      options.desc = "Go to Upper Window";
    }
    {
      mode = "t";
      key = "<C-l>";
      action = "<cmd>wincmd l<cr>";
      options.desc = "Go to Right Window";
    }

    # Resize windows
    {
      mode = "n";
      key = "<C-Up>";
      action = "<cmd>resize +2<cr>";
      options.desc = "Increase Window Height";
    }
    {
      mode = "n";
      key = "<C-Down>";
      action = "<cmd>resize -2<cr>";
      options.desc = "Decrease Window Height";
    }
    {
      mode = "n";
      key = "<C-Left>";
      action = "<cmd>vertical resize -2<cr>";
      options.desc = "Decrease Window Width";
    }
    {
      mode = "n";
      key = "<C-Right>";
      action = "<cmd>vertical resize +2<cr>";
      options.desc = "Increase Window Width";
    }
    {
      mode = "v";
      key = "<A-j>";
      action = ":m '>+1<cr>gv=gv";
      options.desc = "Move Down";
    }
    {
      mode = "v";
      key = "<A-k>";
      action = ":m '<-2<cr>gv=gv";
      options.desc = "Move Up";
    }

    # Move selected line/block up/down in visual mode
    {
      mode = "v";
      key = "<A-j>";
      action = ":m '>+1<CR>gv=gv";
      options.desc = "Move Down";
    }
    {
      mode = "v";
      key = "<A-k>";
      action = ":m '<-2<CR>gv=gv";
      options.desc = "Move Up";
    }

    # Escape clear search highlight
    {
      mode = ["i" "n"];
      key = "<esc>";
      action = "<cmd>noh<cr><esc>";
      options.desc = "Escape and Clear hlsearch";
    }

    # Indenting
    {
      mode = "v";
      key = "<";
      action = "<gv";
    }
    {
      mode = "v";
      key = ">";
      action = ">gv";
    }

    # Code actions
    {
      key = "<leader>la";
      action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
    }

    # Exit terminal
    {
      mode = "t";
      key = "<esc><esc>";
      action = "<c-\\><c-n>";
      options.desc = "Exit terminal";
    }

    # Ui
    {
      key = "<leader>fm";
      action = "<cmd>lua vim.lsp.buf.format()<cr>";
      options.desc = "LSP Format";
    }
    {
      key = "<leader>uw";
      action = "<cmd>set wrap!<cr>";
      options.desc = "Toggle word wrapping";
    }
    {
      key = "<leader>uW";
      action = "<cmd>set linebreak!<cr>";
      options.desc = "Toggle linebreak";
    }
    {
      key = "<leader>uz";
      action = "<cmd>ZenMode<cr>";
      options.desc = "ZenMode";
    }

    # Splits
    {
      mode = "n";
      key = "<leader>sv";
      action = "<C-w>v";
      options.desc = "Split window vertically";
    }
    {
      mode = "n";
      key = "<leader>sh";
      action = "<C-w>s";
      options.desc = "Split window horizontally";
    }
    {
      mode = "n";
      key = "<leader>ss";
      action = "<C-w>=";
      options.desc = "Make splits equal size";
    }
    {
      mode = "n";
      key = "<leader>sx";
      action = "<cmd>close<CR>";
      options.desc = "Close current split";
    }

    # Tabs
    {
      mode = "n";
      key = "<leader>to";
      action = "<cmd>tabnew<CR>";
      options.desc = "Open new tab";
    }
    {
      mode = "n";
      key = "<leader>tx";
      action = "<cmd>tabclose<CR>";
      options.desc = "Close current tab";
    }
    {
      mode = "n";
      key = "<leader>tn";
      action = "<cmd>tabn<CR>";
      options.desc = "Go to next tab";
    }
    {
      mode = "n";
      key = "<leader>tp";
      action = "<cmd>tabp<CR>";
      options.desc = "Go to previous tab";
    }

    # Keep cursor centered while scrolling
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
      options.desc = "Scroll up";
    }
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
      options.desc = "Scroll down";
    }
  ];
}
