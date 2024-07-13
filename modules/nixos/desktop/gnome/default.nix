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

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      excludePackages = [ pkgs.xterm ];
    };

    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      gedit
      epiphany
      geary
      yelp
      gnome-font-viewer
      gnome-system-monitor
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
    
    environment.systemPackages = with pkgs.gnomeExtensions; [ 
        tray-icons-reloaded
      ];
    
    services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

    programs.dconf.enable = true;
    home.extraOptions.dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;

        # `gnome-extensions list` for a list
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "trayIconsReloaded@selfmade.pl"
        ];
      };
      "org/gnome/shell/extensions/user-theme" = {  
        name = "catppuccin-mocha-lavender-standard+normal";
      };

    };

  };
}
