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
    
    services.ssh.enable = true;
    services.printing.enable = true;

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
    apps.firefox.enable = true;
    apps.alacritty.enable = true;
    apps.steam.enable = true;
    environment.systemPackages = with pkgs; [
       
    ];
  };
}
