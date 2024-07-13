{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.boot.bios;
in {
  options.system.boot.bios = with types; {
    enable = mkBoolOpt false "Whether or not to enable bios booting.";
    device = mkOpt str "nodev" "Disk that grub will be installed to.";
  };

  config = mkIf cfg.enable {
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      useOSProber = true;
      device = "nodev";
    };
  };
}
