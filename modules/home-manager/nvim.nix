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
}
