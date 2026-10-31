{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.minimal;
in {
  options.suites.minimal = with types; {
    enable = mkBoolOpt false "Enable the minimal suite";
  };

  config = mkIf cfg.enable {
    system.nix.enable = true;

    hardware.audio.enable = true;
    hardware.networking.enable = true;
    hardware.bt.enable = true;



    services = {
      # ssh.enable = true;
      printing.enable = true;
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
      niri.enable = true;
    };

    apps = {
      alacritty.enable = true;
      vscodium.enable = true;
      utils.enable = true;

      firefox.enable = true;
      nautilus.enable = true;
      foliate.enable = true;      
    
      tailscale.enable = true;
      transmission.enable = true;
    };

  };
}
