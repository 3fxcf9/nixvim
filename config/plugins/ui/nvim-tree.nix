{
  plugins.nvim-tree = {
    enable = true;
    openOnSetup = true;
    syncRootWithCwd = true;
    updateFocusedFile.enable = true;
    renderer.indentMarkers.enable = true;
    view = {
      width = 35;
      relativenumber = true;
      side = "right";
    };
    git.ignore = false;
    renderer.specialFiles = [
      "Cargo.toml"
      "Makefile"
      "README.md"
      "readme.md"
      "v.mod"
    ];
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ee";
      action = "<cmd>NvimTreeToggle<CR>";
      options.desc = "Toggle";
    }
    {
      mode = "n";
      key = "<leader>ef";
      action = "<cmd>NvimTreeFindFile<CR>";
      options.desc = "Focus current file";
    }
    {
      mode = "n";
      key = "<leader>et";
      action = "<cmd>NvimTreeFocus<CR>";
      options.desc = "Focus tree";
    }
    {
      mode = "n";
      key = "<leader>er";
      action = "<cmd>NvimTreeRefresh<CR>";
      options.desc = "Refresh";
    }
  ];
}
