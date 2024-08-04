# Nixvim config

My neovim configuration using Nixvim.

## Running

To test the configuration, simply run

```bash
nix run 'github:3fxcf9/nixvim'
```

Or inside the repository folder

```bash
nix run .
```

## Installation on a NixOS system

1. Add the configuration as an input:

```nix
{
  inputs = {
    nixvim.url = "github:3fxcf9/nixvim";
  };
}
```

2. Reference the derivation inside either `environment.systemPackages` or `home.packages`:

```nix
{ inputs, system, ... }:
{
  # NixOS
  environment.systemPackages = [ inputs.nixvim.packages.${pkgs.system}.default ];
  # home-manager
  home.packages = [ inputs.nixvim.packages.${pkgs.system}.default ];
}
```

Neovim is now configured and ready to be used !

## TODO

- Fix motions keys in nvim-tree (swap j and r)
- Lualine: colors, items
- Which-key: add borders
- Folds
- Plugins
