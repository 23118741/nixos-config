{
  pkgs,
  inputs,
  lib,
  ...
}:

let
  # Load your general config (Partial file)
  generalConfig = import ../nvf-config.nix { inherit pkgs; };
in
{
  imports = [
    inputs.nvf.homeManagerModules.default
    # Import Avante as a proper module now
    ../../modules/avante.nix
  ];

  programs.nvf = {
    enable = true;

    # We only apply the general config here.
    # Avante is handled via the imports above.
    settings = generalConfig;
  };
}
