{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.addons.dconf;
in {
  options.desktop.addons.dconf = with types; {
    enable = mkBoolOpt false "Enable or disable dconf";
  };

  config = mkIf cfg.enable {
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
          "appindicatorsupportrgcjonas@gmail.com"
        ];
      };
      "org/gnome/shell/extensions/user-theme" = {  
        name = "catppuccin-mocha-lavender-standard+normal";
      };

      "org/gnome/desktop/interface" = {
        show-battery-percentage = true;
      };

      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
        two-finger-scrolling-enabled = true;
      };

      "org/gnome/desktop/search-providers" = {
        disabled = [ "org.gnome.Boxes.desktop" ];
        enabled = [ "org.gnome.Weather.desktop" ];
        sort-order = [
          "org.gnome.Contacts.desktop"
          "org.gnome.Documents.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Calendar.desktop"
          "org.gnome.Calculator.desktop"
          "org.gnome.Software.desktop"
          "org.gnome.Settings.desktop"
          "org.gnome.clocks.desktop"
          "org.gnome.design.IconLibrary.desktop"
          "org.gnome.seahorse.Application.desktop"
          "org.gnome.Weather.desktop"
          "org.gnome.Boxes.desktop"
        ];
      };

      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Alt>q" ];
        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];
        move-to-workspace-5 = [ "<Shift><Super>5" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        toggle-fullscreen = [ "<Super>g" ];
      };

      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [];
        switch-to-application-2 = [];
        switch-to-application-3 = [];
        switch-to-application-4 = [];
        switch-to-application-5 = [];
      };

      "org/gnome/desktop/wm/preferences" = {
        mouse-button-modifier = "<Super>";
        num-workspaces = 5;
        resize-with-right-button = true;
        focus-mode = "sloppy";
      };

      "org/gnome/mutter" = {
        dynamic-workspaces = false;
        edge-tiling = true;
        num-workspaces = 5;
        workspaces-only-on-primary = true;
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
        mic-mute = [ "AudioMicMute" ];
        next = [ "AudioNext" ];
        play = [ "AudioPlay" ];
        previous = [ "AudioPrev" ];
        stop = [ "AudioStop" ];
        volume-down = [ "AudioLowerVolume" ];
        volume-up = [ "AudioRaiseVolume" ];

        home = [ "<Super>e" ];
        www = [ "<Super>w" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "alacritty";
        name = "term";
      };

      "org/gnome/settings-daemon/plugins/power" = {
        idle-dim = false;
        power-button-action = "interactive";
      };

      "org/gnome/shell/app-switcher" = {
        current-workspace-only = false;
      };

      "org/gnome/shell/keybindings" = {
        toggle-application-view = [ "<Super>r" ];
      };

      "system/locale" = {
        region = "hu_HU.UTF-8";
      };
    };
  };
}