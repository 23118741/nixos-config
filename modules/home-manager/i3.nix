{ pkgs, lib, ... }:

let
  wallpaperDir = ../../wallpapers;
  wallpaperScript = pkgs.writeShellScriptBin "wallpaper-cycle" ''
    ${pkgs.feh}/bin/feh --bg-scale --randomize ${wallpaperDir}/*
  '';
in
{
  home.packages = with pkgs; [
    feh
    wallpaperScript
    i3status
  ];

  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = "Mod4";

      startup = [
        {
          command = "${wallpaperScript}/bin/wallpaper-cycle";
          always = true;
          notification = false;
        }
      ];

      keybindings = lib.mkOptionDefault {
        "Mod4+Shift+b" = "exec --no-startup-id ${wallpaperScript}/bin/wallpaper-cycle";
      };

      gaps = {
        inner = 10;
        outer = 0;
        smartGaps = true;
      };

      # ---------------------------------------------------
      # 1. WINDOW BORDERS (This was missing!)
      # ---------------------------------------------------
      window = {
        border = 2;
        titlebar = false;
        commands = [
          {
            criteria = {
              class = "^.*";
            };
            command = "border pixel 2";
          }
        ];
      };

      colors = {
        focused = {
          border = "#d79921";
          background = "#d79921";
          text = "#282828";
          indicator = "#d79921";
          childBorder = "#d79921";
        };
        unfocused = {
          border = "#3c3836";
          background = "#3c3836";
          text = "#a89984";
          indicator = "#3c3836";
          childBorder = "#3c3836";
        };
        focusedInactive = {
          border = "#3c3836";
          background = "#3c3836";
          text = "#a89984";
          indicator = "#3c3836";
          childBorder = "#3c3836";
        };
        urgent = {
          border = "#cc241d";
          background = "#cc241d";
          text = "#ebdbb2";
          indicator = "#cc241d";
          childBorder = "#cc241d";
        };
        background = "#282828";
      };

      # ---------------------------------------------------
      # 2. BOTTOM BAR
      # ---------------------------------------------------
      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status}/bin/i3status";

          fonts = {
            names = [
              "DejaVu Sans Mono"
              "FontAwesome"
            ];
            size = 10.0;
          };

          colors = {
            background = "#282828";
            statusline = "#ebdbb2";
            separator = "#665c54";

            focusedWorkspace = {
              border = "#d79921";
              background = "#d79921";
              text = "#282828";
            };

            activeWorkspace = {
              border = "#3c3836";
              background = "#3c3836";
              text = "#ebdbb2";
            };

            inactiveWorkspace = {
              border = "#282828";
              background = "#282828";
              text = "#a89984";
            };

            urgentWorkspace = {
              border = "#cc241d";
              background = "#cc241d";
              text = "#ebdbb2";
            };
          };
        }
      ];
    };
  };

  # Configure the text generator (i3status)
  programs.i3status = {
    enable = true;
    general = {
      colors = true;
      color_good = "#98971a";
      color_degraded = "#d79921";
      color_bad = "#cc241d";
    };
  };
}
