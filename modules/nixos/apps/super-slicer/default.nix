{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.super-slicer;
in
{
  options.apps.super-slicer = with types; {
    enable = mkBoolOpt false "Super Slicer";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ super-slicer ];
  };
}