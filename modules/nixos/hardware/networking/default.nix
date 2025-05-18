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
    networking.networkmanager.enable = true;
    services.avahi = {
        nssmdns = true;
        enable = true;
        ipv4 = true;
        ipv6 = true;
        publish = {
          enable = true;
          addresses = true;
          workstation = true;
        };
    };
    networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];

    services.resolved = {
      enable = true;
      dnssec = "true";
      domains = [ "~." ];
      fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
      dnsovertls = "true";
    };
  };
}
