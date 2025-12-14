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
    # 1. Critical: Enable dconf and put it in system path
    programs.dconf.enable = true;

    # 2. Enable GVFS: Often required for file-transfer apps to interact with DBus correctly
    services.gvfs.enable = true;

    # 3. Register services with DBus explicitly
    services.dbus.packages = with pkgs; [
      dconf
      gvfs
    ];

    # 4. Install packages
    environment.systemPackages = with pkgs; [
      warpinator
      dconf # The binary itself
      libnotify # For notifications
    ];

    # 5. Open Firewall
    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = cfg.tcpPorts;
      allowedUDPPorts = cfg.udpPorts;
    };
  };
}
