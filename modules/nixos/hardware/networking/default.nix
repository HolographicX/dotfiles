{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.networking;
in {
  options.hardware.networking = with types; {
    enable = mkBoolOpt false "Enable networking";
  };

  config = mkIf cfg.enable {
    hardware.enableRedistributableFirmware = true;
    networking.networkmanager.enable = true;

    networking.firewall = {
      enable = true;
      allowedUDPPortRanges = [
        { from = 26000; to = 26999; }
      ];
    };

    services.avahi = {
        nssmdns4 = true;
        enable = true;
        ipv4 = true;
        ipv6 = true;
        publish = {
          enable = true;
          addresses = true;
          workstation = true;
        };
    };
  };
}
