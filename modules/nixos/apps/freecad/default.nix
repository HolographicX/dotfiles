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
  cfg = config.apps.freecad;
in {
  options.apps.freecad = with types; {
    enable = mkBoolOpt false "Enable or disable freecad";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      freecad
    ];
  };
}