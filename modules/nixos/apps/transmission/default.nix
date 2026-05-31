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
  cfg = config.apps.transmission;
in {
  options.apps.transmission = with types; {
    enable = mkBoolOpt false "Enable or disable transmission";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      transmission_4-gtk
    ];

  };
}