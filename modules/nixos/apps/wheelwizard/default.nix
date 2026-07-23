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
  cfg = config.apps.wheelwizard;
in {
  options.apps.wheelwizard = with types; {
    enable = mkBoolOpt false "Enable or disable wheelwizard";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wheelwizard
    ];
  };
}