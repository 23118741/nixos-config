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

    # Import BOTH modules now
    ../../modules/avante.nix
    ../../modules/codeium.nix
  ];

  programs.nvf = {
    enable = true;
    settings = generalConfig;
  };
  autocomplete.nvim-cmp = {
    enable = true;
    mappings = {
      confirm = "<CR>";

      # FIX: Move navigation to Ctrl+n/p so Tab is free for Codeium
      next = "<C-n>";
      previous = "<C-p>";
    };
  };
}
