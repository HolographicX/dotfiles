{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.astronomy;
in {
  options.apps.arduino = with types; {
    enable = mkBoolOpt false "Enable or disable astronomy softwave";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      stellarium
      indilib
      kstars
    ];


  };
}