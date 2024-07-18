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
  cfg = config.desktop.addons.ags;
in {
  options.desktop.addons.ags = with types; {
    enable = mkBoolOpt false "Enable or disable anyrun";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      material-symbols
      gammastep
      ollama
      pywal
      dart-sass
      (python311.withPackages (p: [
        p.pillow
        p.material-color-utilities
        p.libsass
        p.setproctitle # for keep system awake
        p.pywayland # for keep system awake
        p.psutil
      ]))
    ];

    home = {

      extraOptions = {
        imports = [
          inputs.ags.homeManagerModules.default
        ];
      };

      programs.ags = {
        enable = true;
        # configDir = null; # if ags dir is managed by home-manager, it'll end up being read-only. not too cool.
        # configDir = ../../.config/ags;

        extraPackages = with pkgs; [
          gtksourceview
          gtksourceview4
          ollama
          python311Packages.material-color-utilities
          python311Packages.pywayland
          pywal
          sassc
          webkitgtk
          webp-pixbuf-loader
          ydotool
        ];
      };
    };
    home.configFile."ags" = {
      source = ../../.config/ags;
      recursive = true;
      executable = true;
    };
  };
}