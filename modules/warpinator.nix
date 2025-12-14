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
    # 1. Enable dconf program (required for settings)
    programs.dconf.enable = true;

    # 2. Register dconf with DBus explicitly so the service can be found
    services.dbus.packages = [ pkgs.dconf ];

    # 3. Install Warpinator
    environment.systemPackages = [ pkgs.warpinator ];

    # 4. Open Firewall
    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = cfg.tcpPorts;
      allowedUDPPorts = cfg.udpPorts;
    };
  };
}
