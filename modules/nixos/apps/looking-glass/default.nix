{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.looking-glass;
in
{
  options.apps.looking-glass = with types; {
    enable = mkBoolOpt false "looking-glass for VMs.";
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 alex qemu-libvirtd -"
    ];
    environment.systemPackages = with pkgs; [ looking-glass-client ];

    # add this to the vm config:
    # <shmem name='looking-glass'>
    #   <model type='ivshmem-plain'/>
    #   <size unit='M'>32</size>
    #   <address type='pci' domain='0x0000' bus='0x0b' slot='0x01' function='0x0'/>
    # </shmem>
  };
}