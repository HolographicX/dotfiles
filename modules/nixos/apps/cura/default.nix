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
  cfg = config.apps.cura;
in {
  options.apps.cura = with types; {
    enable = mkBoolOpt false "Enable or disable cura";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cura
    ];
  };
}