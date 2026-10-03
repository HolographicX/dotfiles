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
  cfg = config.apps.rapidraw;
in {
  options.apps.rapidraw = with types; {
    enable = mkBoolOpt false "Enable or disable rapidraw";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rapidraw
    ];
  };
}