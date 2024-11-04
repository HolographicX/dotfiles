{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.virt-manager;
  gpuIDs = [
    "10de:2520" # Graphics
    "10de:228e" # Audio
  ];
in
{
  options.apps.virt-manager = with types; {
    enable = mkBoolOpt false "Virt-manager with Looking glass and GPU passthrough support.";
  };

  config = mkIf cfg.enable {
    programs.virt-manager.enable = true;
    users.users.soham.extraGroups = [ "libvirtd" "qemu-libvirtd" ];
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        vhostUserPackages = with pkgs; [ virtiofsd ];
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
    # USB redirection in virtual machine
    virtualisation.spiceUSBRedirection.enable = true;
  
    # looking glaass
    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 soham qemu-libvirtd -"
    ];
    
      environment.systemPackages = with pkgs; [ looking-glass-client ];

  };
}
