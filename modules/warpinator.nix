{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.warpinator;
in
{
  options.programs.warpinator = {
    enable = mkEnableOption "Warpinator file sharing";

    openFirewall = mkOption {
      type = types.bool;
      default = true;
      description = "Open firewall ports for Warpinator";
    };

    tcpPorts = mkOption {
      type = types.listOf types.port;
      default = [
        42000
        42001
      ];
      description = "TCP ports for Warpinator";
    };

    udpPorts = mkOption {
      type = types.listOf types.port;
      default = [
        42000
        42001
      ];
      description = "UDP ports for Warpinator";
    };
  };

  config = mkIf cfg.enable {
    # 1. Enable dconf (Critical for settings)
    programs.dconf.enable = true;

    # 2. Tell DBus where to find the dconf service file
    services.dbus.packages = [ pkgs.dconf ];

    # 3. Install packages
    environment.systemPackages = with pkgs; [
      warpinator
      glib # Helpers for gsettings
      gsettings-desktop-schemas # Standard schemas
    ];

    # 4. Open Firewall
    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = cfg.tcpPorts;
      allowedUDPPorts = cfg.udpPorts;
    };
  };
}
