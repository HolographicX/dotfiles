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
    # TODO: Split apps according to suites
    apps = {
      misc.enable = true;
      firefox.enable = true;
      alacritty.enable = true;
      steam.enable = true;
      discord.enable = true;
      vscodium.enable = true;
      lutris.enable = true;
      cemu.enable = true;
      cartridges.enable = true;
      ludusavi.enable = true;
      feishin.enable = true;
      libreoffice.enable = true;
      minecraft.enable = true;
      obsidian.enable = true;
      tools = {
        tailscale.enable = true;
        warp.enable = true;
        piper.enable = true;
      };
    };
    
    services = {
      easyeffects.enable = true;
    };
  };
}
