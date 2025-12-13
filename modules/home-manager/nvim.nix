{
  pkgs,
  inputs,
  lib,
  ...
}:

let
  generalConfig = import ../nvf-config.nix { inherit pkgs; };
in
{
  imports = [
    inputs.nvf.homeManagerModules.default
    ../../modules/avante.nix
    ../../modules/codeium.nix
  ];

  programs.nvf = {
    enable = true;

    # Merge general config with our manual overrides
    settings = lib.mkMerge [
      generalConfig

      # Manual Override Block
      {
        vim.autocomplete.nvim-cmp = {
          enable = true;
          mappings = {
            confirm = "<CR>";
            next = "<C-n>";
            previous = "<C-p>";
          };
        };
      }
    ];
  };
}
