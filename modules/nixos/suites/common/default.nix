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
    services = {
      easyeffects.enable = true;
      ssh.enable = true;
      polkit.enable = true;
      printing.enable = true;
      flatpak.enable = true;

    };

    
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
      utils.enable = true;
      firefox.enable = true;
      alacritty.enable = true;
      steam.enable = true;
      discord.enable = true;
      vscodium.enable = true;
      lutris.enable = true;
      cemu.enable = true;
      ludusavi.enable = true;
      feishin.enable = true;
      libreoffice.enable = true;
      minecraft.enable = true;
      obsidian.enable = true;
      transmission.enable = true;
      chromium.enable = true;
      tools = {
        tailscale.enable = true;
        warp.enable = true;
        piper.enable = true;
      };
    };
    
  };
}
