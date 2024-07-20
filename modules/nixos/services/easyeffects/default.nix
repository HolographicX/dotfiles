{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.services.easyeffects;
in {
  options.services.easyeffects = with types; {
    enable = mkBoolOpt false "Enable easyeffects";
  };

  config = mkIf cfg.enable {
    home.extraOptions = {
     services.easyeffects.enable = true;
    };
  };
}
