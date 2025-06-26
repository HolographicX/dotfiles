{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.swap;
in {
  options.hardware.swap = with types; {
    enable = mkBoolOpt false "Enable pipewire";
  };

  config = mkIf cfg.enable {
    swapDevices = lib.mkForce [ {
      device = "/var/lib/swapfile";
      size = 32*1024;
    } ];

  };
}