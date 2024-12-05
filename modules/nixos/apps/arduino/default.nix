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
  cfg = config.apps.arduino;
in {
  options.apps.arduino = with types; {
    enable = mkBoolOpt false "Enable or disable arduino";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      arduino-ide
      esptool
      python312Packages.pyserial
    ];
  };
}