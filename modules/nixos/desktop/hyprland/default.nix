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
    };


    environment.systemPackages = with pkgs; [
      ### Basic
      axel
      cliphist

      ### Player and Audio
      pavucontrol
      libdbusmenu
      playerctl
      swww

      ### GTK
      webp-pixbuf-loader
      gtk-layer-shell
      gtk3
      yad
      ydotool

      ### Gnome
      gnome.gnome-keyring
      gnome.gnome-control-center
      gammastep

      ### Widgets
      hyprlock
      hypridle
      wlogout
      wl-clipboard

      ### Fonts and Themes
      # fonts are in nixos.nix
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
      source = "../.local/bin";
      recursive = true;
    };
    xdg.configFile = let
      mkCfg = name: {
        source = "../.config/${name}";
        recursive = true;
      };
    in {
      "hypr/custom" = mkCfg "hypr/custom";
      "hypr/hyprland" = mkCfg "hypr/hyprland";
      "hypr/hyprlock" = mkCfg "hypr/hyprlock";
      "hypr/shaders" = mkCfg "hypr/shaders";
      "hypridle.conf" = mkCfg "hypridle.conf";
      "hyprlock.conf" = mkCfg "hyprlock.conf";
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
      extraConfig = builtins.readFile ("../.config/hypr/hyprland.conf");
    };
  };
}
