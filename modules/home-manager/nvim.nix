{
  pkgs,
  inputs,
  lib,
  ...
}:

let
  # Import the General Config
  generalConfig = import ../nvf-config.nix { inherit pkgs; };
in
{
  imports = [
    inputs.nvf.homeManagerModules.default

    # IMPORT AVANTE HERE
    # This forces it to read the file from disk every time
    ../../modules/avante.nix
  ];

  programs.nvf = {
    enable = true;

    # We apply the general settings, but Avante is handled
    # automatically by the import above.
    settings = generalConfig;
  };
}
