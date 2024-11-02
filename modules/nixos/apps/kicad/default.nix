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
  cfg = config.apps.kicad;
in {
  options.apps.kicad = with types; {
    enable = mkBoolOpt false "Enable or disable kicad";
  };

  config = mkIf cfg.enable {
  environment.systemPackages = with pkgs; [ kicad ];
  };
}