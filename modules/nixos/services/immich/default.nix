{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.services.immich;
in {
  options.services.immich = with types; {
    enable = mkBoolOpt false "Enable immich";
  };

  config = mkIf cfg.enable {
    services.immich.enable = true;
    services.immich.port = 2283;
    services.immich.host = "0.0.0.0";
    services.immich.openFirewall = true;
    services.immich.accelerationDevices = null;

    users.users.immich.extraGroups = [ "video" "render" ];

  };
}
