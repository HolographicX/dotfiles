{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.server;
in {
  options.suites.server = with types; {
    enable = mkBoolOpt false "Enable the server suite";
  };

  config = mkIf cfg.enable {
    system.nix.enable = true;

    hardware.audio.enable = true;
    hardware.networking.enable = true;
    hardware.bt.enable = true;



    services = {
      ssh.enable = true;
    };

    security.polkit.enable = true;
    
    system = {
      fonts.enable = true;
      time.enable = true;
      shell.enable = true;
    };

    apps = {
      utils.enable = true;
      tailscale.enable = true;
    };

  };
}
