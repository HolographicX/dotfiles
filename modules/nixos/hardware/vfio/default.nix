{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.vfio;
  gpuIDs = [
    "10de:2520" # Graphics
    "10de:228e" # Audio
  ];
in
{
  options.hardware.vfio = with types; {
    enable = mkBoolOpt false "GPU passthrough support for vfio.";
  };

  config = mkIf cfg.enable {
    boot = {
      initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"

        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];

      kernelParams = [
        # enable IOMMU
        "amd_iommu=on"
      ] ++ lib.optional cfg.enable
        # isolate the GPU
        ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
    };

    virtualisation.spiceUSBRedirection.enable = true;
  };
}