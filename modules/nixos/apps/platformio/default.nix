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
  cfg = config.apps.platformio;
in {
  options.apps.platformio = with types; {
    enable = mkBoolOpt false "Enable or disable platformio";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      platformio
      esptool
    ];
  };
}
