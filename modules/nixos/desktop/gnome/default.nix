{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.gnome;
in {
  options.desktop.gnome = with types; {
    enable = mkBoolOpt false "Enable gnome.";
  };

  config = mkIf cfg.enable {
    desktop.addons = {
      dconf.enable = true;
    };

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      excludePackages = [ pkgs.xterm ];
    };
    
    environment.gnome.excludePackages = (with pkgs; [
      gnome-connections
      gnome-photos
      gnome-tour
      gedit
      epiphany
      geary
      yelp
      gnome-font-viewer
    ]) ++ (with pkgs.gnome; [
      gnome-music
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      gnome-contacts
      gnome-initial-setup
      gnome-maps
    ]);
    services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };
}
