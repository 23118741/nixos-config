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
    # CRITICAL: Fixes the dconf/gsettings error
    programs.dconf.enable = true;

    # Install the package
    environment.systemPackages = [ pkgs.warpinator ];

    # Open the ports
    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = cfg.tcpPorts;
      allowedUDPPorts = cfg.udpPorts;
    };
  };
}
