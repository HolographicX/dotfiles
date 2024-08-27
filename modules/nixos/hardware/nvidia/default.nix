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
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    hardware.nvidia.powerManagement = {
      enable = true;
      # finegrained = true;
    };
    # hardware.nvidia.prime = {
    #   # Make sure to use the correct Bus ID values for your system!
    #   intelBusId = "PCI:0:2:0";
    #   nvidiaBusId = "PCI:1:0:0";
    # };

    # boot.initrd.kernelModules = [ "nvidia" "nvidia_drm" "nvidia_uvm" "nvidia_modeset" ];
    # OpenGL support
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [ pkgs.mesa.drivers ];
    };

    environment.variables = {
      CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
    };
    environment.shellAliases = {nvidia-settings = "nvidia-settings --config='$XDG_CONFIG_HOME'/nvidia/settings";};

    # Hyprland settings
    environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1"; # Fix cursor rendering issue on wlr nvidia.
  };
}
