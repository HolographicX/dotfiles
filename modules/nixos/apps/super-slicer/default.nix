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
  cfg = config.apps.super-slicer;
in {
  options.apps.super-slicer = with types; {
    enable = mkBoolOpt false "Enable or disable super-slicer";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ super-slicer-latest ];
  };
}