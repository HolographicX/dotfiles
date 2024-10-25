{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.qemu;
in
{
  options.apps.qemu = with types; {
    enable = mkBoolOpt false "qemu.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ quickemu samba ]; # samba for windows file sharing
  };
}