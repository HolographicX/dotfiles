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
    services.xserver.videoDrivers = ["nvidia" "intel"];
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    hardware.nvidia.powerManagement = {
      enable = true;
      finegrained = true;
    };

    # OpenGL support
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [ pkgs.mesa.drivers ];
    };

    environment.variables = {
      LD_LIBRARY_PATH="/run/opengl-driver/lib:/run/opengl-driver-32/lib";
      CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
    };
    environment.shellAliases = {nvidia-settings = "nvidia-settings --config='$XDG_CONFIG_HOME'/nvidia/settings";};

    # Hyprland settings
    programs.hyprland.enableNvidiaPatches = true;
    environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1"; # Fix cursor rendering issue on wlr nvidia.
  };
}
