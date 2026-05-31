{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.bt;
in {
  options.hardware.bt = with types; {
    enable = mkBoolOpt false "Enable networking";
  };

  config = mkIf cfg.enable {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;

        settings = {
          General = {
            Experimental = true;
          };

          Policy = {
            AutoEnable = true;
          };
        };
      };

      services.blueman.enable = true;

      hardware.xpadneo.enable = true; # xbox controllers
      boot.kernelModules = [ "hid-playstation" ]; # dualsense controllers

      # nintendo controllers
      services.joycond.enable = true;
      services.udev.packages = with pkgs; [ game-devices-udev ];

  };
}
