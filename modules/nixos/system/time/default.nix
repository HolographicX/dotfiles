{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.time;
in {
  options.system.time = with types; {
    enable =
      mkBoolOpt false "Whether or not to configure timezone information.";
  };

  config = mkIf cfg.enable {
    services.geoclue2.enable = true;
    services.automatic-timezoned.enable = true;
  };
}
