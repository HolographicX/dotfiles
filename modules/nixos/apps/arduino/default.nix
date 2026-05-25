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
    enable = mkBoolOpt false "Enable or disable arduino + platformio";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      arduino-ide
      platformio
      esptool
    ];
    services.udev.packages = [ 
      pkgs.platformio-core
      pkgs.openocd
    ];

    programs.nix-ld.libraries = with pkgs; [avrdude];

  };
}