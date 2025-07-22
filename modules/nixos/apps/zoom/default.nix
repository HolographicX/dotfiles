{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.zoom;
in {
  options.apps.zoom = with types; {
    enable = mkBoolOpt false "Enable or disable zoom";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = [
      "us.zoom.Zoom"
    ];
  };
}