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
      "f /dev/shm/looking-glass 0660 soham qemu-libvirtd -"
    ];
    environment.systemPackages = with pkgs; [ looking-glass-client ];
  };
}