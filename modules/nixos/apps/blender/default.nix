{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.blender;
in {
  options.apps.blender = with types; {
    enable = mkBoolOpt false "Enable or disable blender";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ blender_4_2 ]; # from blender-bin flake
  };
}