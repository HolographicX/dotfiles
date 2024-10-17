{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.zoom;
in
{
  options.apps.zoom = with types; {
    enable = mkBoolOpt false "Zoom.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ zoom-us ];
  };
}