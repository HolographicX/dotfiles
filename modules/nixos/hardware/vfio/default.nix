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
    programs.virt-manager.enable = true;
    users.users.soham.extraGroups = [ "libvirtd" ];
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
      };
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
  
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
      
      kernelModules = [ "kvm-intel" ];
      kernelParams = [
        # enable IOMMU
        "intel_iommu=on"
      ]  ++ [("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)];
    };

    virtualisation.spiceUSBRedirection.enable = true;
  };
}