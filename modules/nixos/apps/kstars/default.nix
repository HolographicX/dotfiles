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
  cfg = config.apps.kstars;
in {
  options.apps.kstars = with types; {
    enable = mkBoolOpt false "Enable or disable kstars";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kstars
    ];
  };
}