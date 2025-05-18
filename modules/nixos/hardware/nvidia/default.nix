{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.nvidia;
in {
  options.hardware.nvidia = with types; {
    enable = mkBoolOpt false "Enable drivers and patches for Nvidia hardware.";
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.open = false;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

    hardware.nvidia.powerManagement = {
      enable = true;
      finegrained = true;
    };


    hardware.nvidia.nvidiaSettings = true;
    # OpenGL support
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [ pkgs.mesa.drivers ];
    };

    environment.variables = {
      CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
    };

    # boot = {
    #   initrd.kernelModules = [ "nvidia" "i915" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    #   kernelParams = [ "nvidia-drm.fbdev=1" ];
    # };
  };
}
