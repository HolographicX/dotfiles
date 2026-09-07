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
        package = pkgs.bluez5-experimental;
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

      environment.systemPackages = with pkgs; [
        overskride
      ];

      hardware.xpadneo.enable = true; # xbox controllers
      boot.kernelModules = [ "hid-playstation" ]; # dualsense controllers
      services.joycond.enable = true; # nintendo controllers
      
      services.udev.packages = with pkgs; [ game-devices-udev-rules ];

  };
}
