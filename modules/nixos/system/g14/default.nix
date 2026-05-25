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
    enable = mkBoolOpt false "Whether or not to enable g14 packages.";
  };
  
  config = mkIf cfg.enable {

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
          hotplug_type = "Asus";
        };
      };
      asusd.enable = true;
      asusd.asusdConfig.source = "/etc/asusd/asusd.ron";
    };
    
    boot.kernelParams = ["nvidia-drm.modeset=1" "mem_sleep_default=deep" "amdgpu.dcdebugmask=0x10"];
    boot.blacklistedKernelModules = ["noveau"];
  
  };
}