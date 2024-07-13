{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  cfg = config.desktop.hyprland;

  plugins = inputs.hyprland-plugins.packages.${pkgs.system};

in
{
  options.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable hyprland";
  };
  config = mkIf cfg.enable {
    # desktop.addons = {

    # };


    environment.systemPackages = with pkgs; [
      libinput
      volumectl
      playerctl
      brightnessctl
      glib
      gtk3.out
      gnome.gnome-control-center
      ags
      libdbusmenu-gtk3
    ];

    environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
    environment.sessionVariables._JAVA_AWT_WM_NONREPARENTING = "1";
    environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland

    # hack gnome settings into hyprland
    xdg.desktopEntries."org.gnome.Settings" = {
        name = "Settings";
        comment = "Gnome Control Center";
        icon = "org.gnome.Settings";
        exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
        categories = [ "X-Preferences" ];
        terminal = false;
    };

    programs.dconf.enable = true;

    home = {
      packages = with pkgs; [
        launcher
        adoptopenjdk-jre-bin
      ];
        programs = {
          hyprland.enable = true;
          hyprland.xwayland.enable = true;
          swaylock = {
            enable = true;
            package = pkgs.swaylock-effects;
          };
        };
    
    };
  };
}