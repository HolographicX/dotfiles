{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.siril;
in {
  options.apps.siril = with types; {
    enable = mkBoolOpt false "Enable or disable siril";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.custom.siril
    ];
  };
}