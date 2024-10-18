{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.freecad;
in
{
  options.apps.freecad = with types; {
    enable = mkBoolOpt false "Freecad.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ freecad ];
  };
}