{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hosted.immich;
in {
  options.hosted.immich = with types; {
    enable = mkBoolOpt false "Enable immich";
  };

  config = mkIf cfg.enable {
    services.immich.enable = true;
    services.immich.port = 2283;
    services.immich.host = "0.0.0.0";
    services.immich.openFirewall = true;
    services.immich.accelerationDevices = null;
    # services.immich.mediaLocation = "/mnt/media/immich";
    users.users.postgres.ignoreShellProgramCheck = true;
    users.users.immich.extraGroups = [ "video" "render" ];

  };
}
