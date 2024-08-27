{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.g14;
in {
  options.system.g14 = with types; {
    enable = mkBoolOpt false "Whether or not to enable g14 patches.";
  };
  
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      supergfxctl
      asusctl
    ];

    services = {
      supergfxd = {
        enable = true;
        settings = {
          mode = "Hybrid";
          vfio_enable = true;
          vfio_save = true;
          always_reboot = false;
          no_logind = false;
          logout_timeout_s = 180;
          hotplug_type = "None";
        };
      };
      asusd = {
        enable = true;
        enableUserService = true;
      };
    };
  };
}