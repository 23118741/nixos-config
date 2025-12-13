{ pkgs, inputs, ... }:

{
  # Import NVF module from inputs
  imports = [
    inputs.nvf.homeManagerModules.default
    ../../modules/avante.nix
  ];

  programs.nvf = {
    enable = true;

    # IMPORT THE SHARED CONFIG HERE
    settings = import ../nvf-config.nix { inherit pkgs; };
  };
}
