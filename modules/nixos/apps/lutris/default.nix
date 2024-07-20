{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.lutris;
in {
  options.apps.lutris = with types; {
    enable = mkBoolOpt false "Enable or disable firefox browser";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lutris
    ];
  };
}