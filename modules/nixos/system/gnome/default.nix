{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.gnome;
in {
  options.system.gnome = with types; {
    enable = mkBoolOpt false "Enable gnome.";
  };

  config = mkIf cfg.enable {

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      gedit
      epiphany
      geary
      yelp
    ]) ++ (with pkgs.gnome; [
      gnome-music
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      gnome-contacts
      gnome-initial-setup
    ]);
    
    environment.systemPackages = with pkgs; [ 
        gnomeExtensions.tray-icons-reloaded
      ];
    
    services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

    programs.dconf.enable = true;

  };
}
