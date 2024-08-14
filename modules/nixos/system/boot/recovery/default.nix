{
  options,
  config,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.boot.recovery;
in {
  options.system.boot.recovery = with types; {
    enable = mkBoolOpt false "Whether or not to enable a recovery boot entry.";
    # isolatedBootTarget = inputs.nixpkgs.lib.nixosSystem {
    #   system = "x86_64-linux";
    #   configuration = {
    #     imports = [ "${inputs.nixpkgs}/nixos/modules/installer/netboot/netboot-minimal.nix" ];
    #     networking.wireless.enable = true;
    #     users.users.root.hashedPassword = "$6$byzpnVzQ.CrzMMI1$Dxag5lu8jpsrtsDli0TCTxywSyd2HS7EK.gOYpZY5zWS1noLoX7mHdA2sDHVLel6CuZOA7oSZxUXBL0GYyfTP1"; 
    #   };
    # };
  };

  config = mkIf cfg.enable {
    # boot.loader.systemd-boot.extraEntries = {
    # "isolated-boot.conf" = ''
    #   title   NixOS (Recovery)
    #   linux   ${isolatedBootTarget.config.system.build.kernel}/bzImage
    #   initrd  ${isolatedBootTarget.config.system.build.netbootRamdisk}/initrd
    #   options init=/nix/store/.../init
    # '';
    # };

  };
}
