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
    hardware.bluetooth.enable = true;


    services = {
      ssh.enable = true;
      printing.enable = true;
      flatpak.enable = true;
      upower.enable = true;
    };

    security.polkit.enable = true;
    
    system = {
      fonts.enable = true;
      time.enable = true;
      theme.enable = true;
      shell.enable = true;
    };

    desktop = {
      hyprland.enable = true;
    };

    apps = {
      alacritty.enable = true;
      vscodium.enable = true;
      opencode.enable = true;
      utils.enable = true;

      firefox.enable = true;
      nautilus.enable = true;

      rpi-imager.enable = true;
      arduino.enable = true;
      vesktop.enable = true;
      kicad.enable = true;
      another-rawtherapee.enable = true;
      tailscale.enable = true;

      # gaming
      steam.enable = true;
      eden.enable = true;
      dolphin.enable = true;
      cemu.enable = true;
    };

  };
}
