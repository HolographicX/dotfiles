{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.rpi-imager;
in
{
  options.apps.rpi-imager = with types; {
    enable = mkBoolOpt false "rpi-imager.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      rpi-imager 
    ];
  };
}