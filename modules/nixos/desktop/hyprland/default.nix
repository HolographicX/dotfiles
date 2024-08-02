{ config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.hyprland;

  plugins = inputs.hyprland-plugins.packages.${pkgs.system};

in
{
  options.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable hyprland";
  };
  config = mkIf cfg.enable {
    desktop.addons = {
      anyrun.enable = true;
      ags.enable = true;
      fuzzel.enable = true;
      dconf.enable = true;
      ollama.enable = true;
    };


    environment.systemPackages = with pkgs; [
      ### Utils
      axel
      cliphist

      ### Player and Audio
      pavucontrol
      libdbusmenu
      playerctl
      swww
      blueberry

      ### GTK
      webp-pixbuf-loader
      gtk-layer-shell
      gtk3
      yad
      ydotool

      ### Gnome
      gnome-keyring
      gnome.gnome-control-center

      ### Widgets
      hyprlock
      hypridle
      wlogout
      wl-clipboard

      ### Fonts and Themes
      adw-gtk3
      libsForQt5.qt5ct

      ### Screenshot and Recorder
      swappy
      wf-recorder
      grim
      tesseract

      ### Other Packages
      adoptopenjdk-jre-bin
      bc
      brightnessctl
      hyprpicker
      imagemagick
      jq
      swayidle
      slurp
      wayshot
      wlsunset
    ];

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
    };
    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;
    
    home.file.".local/bin" = {
      source = ../.local/bin;
      recursive = true;
    };

    home.configFile = let
      mkCfg = name: {
        source = ../.config + name;
        recursive = true;
      };
    in {
      "hypr/custom" = mkCfg "/hypr/custom";
      "hypr/hyprland" = mkCfg "/hypr/hyprland";
      "hypr/hyprlock" = mkCfg "/hypr/hyprlock";
      "hypr/shaders" = mkCfg "/hypr/shaders";
      "hypr/hypridle.conf" = mkCfg "/hypr/hypridle.conf";
      "hypr/hyprlock.conf" = mkCfg "/hypr/hyprlock.conf";
    };
    home.extraOptions = {
        # hack gnome settings into hyprland
        xdg.desktopEntries."org.gnome.Settings" = {
          name = "Settings";
          comment = "Gnome Control Center";
          icon = "org.gnome.Settings";
          exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
          categories = [ "X-Preferences" ];
          terminal = false;
        };

      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        systemd.enable = true;
        settings = {
          exec-once = [
            "ags"
          ];
        };
        extraConfig = builtins.readFile (../.config/hypr/hyprland.conf);
      };
    };
  };
}
