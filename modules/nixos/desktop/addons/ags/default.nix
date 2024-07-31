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
      ddcutil
      ollama
      pywal
      dart-sass
      gradience
      gammastep
      foot
      gojq
      libnotify
      glib
      (python312.withPackages (p: [
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
        extraPackages = with pkgs; [
          gtksourceview
          material-symbols
        ];
      };
    };
    home.configFile = {
      "ags" = {
        source = ../../.config/ags;
        recursive = true;
        executable = true;
      };
    };
  };
}
