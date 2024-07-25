{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.common;
in {
  options.suites.common = with types; {
    enable = mkBoolOpt false "Enable the common suite";
  };

  config = mkIf cfg.enable {
    system.nix.enable = true;

    hardware.audio.enable = true;
    hardware.networking.enable = true;
    hardware.nvidia.enable = true;
    
    services.ssh.enable = true;
    services.printing.enable = true;
    services.flatpak.enable = true;
    
    environment.systemPackages = [ pkgs.custom.sys ];

    system = {
      fonts.enable = true;
      locale.enable = true;
      time.enable = true;
      xkb.enable = true;
      theme.enable = true;
    };

    desktop = {
      gnome.enable = true;
      hyprland.enable = true;
    };

    # --- apps and stuff -----
    apps.misc.enable = true;
    apps.firefox.enable = true;
    apps.alacritty.enable = true;
    apps.steam.enable = true;
    apps.discord.enable = true;
    apps.vscodium.enable = true;
    apps.lutris.enable = true;
    apps.cemu.enable = true;
    apps.cartridges.enable = true;
    services.easyeffects.enable = true;
    apps.ludusavi.enable = true;
    apps.feishin.enable = true;
    apps.tailscale.enable = true;
    apps.onlyoffice.enable = true;
  };
}
