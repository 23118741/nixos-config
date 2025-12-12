{ config, pkgs, lib, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the i3 window manager.
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu    # application launcher
      i3status # basic status bar
      i3lock   # default screen locker
      i3blocks # a more modern status bar
      # Add other i3-related packages here
      rofi
      picom
      polybar
    ];
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # Enable a display manager (login screen)
  services.displayManager.sddm.enable = true;
}
