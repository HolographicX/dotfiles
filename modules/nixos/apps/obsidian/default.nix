{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.obsidian;
in
{
  options.apps.obsidian = with types; {
    enable = mkBoolOpt false "Obsidian.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ obsidian ];
  };
}