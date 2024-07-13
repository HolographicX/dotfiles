
{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.theme;
  inherit
    (inputs.nix-colors.lib-contrib {inherit pkgs;})
    gtkThemeFromScheme
    ;
    colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
in {
  options.system.theme = with types; {
    enable = mkBoolOpt false "Enable theme";
  };

  config =
    mkIf cfg.enable {
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };
      home.extraOptions = with inputs; {
        
        imports = [
          catppuccin.homeManagerModules.catppuccin 
          nix-colors.homeManagerModules.default
        ];
        catppuccin = {
          accent = "lavender";
          enable = true;
          flavor = "mocha";
          pointerCursor.enable = true;
        };
        gtk = with pkgs; {
          enable = true;
          catppuccin.enable = true;

          iconTheme = {
            name = "MoreWaita";
            package = pkgs.morewaita-icon-theme;
          };
          cursorTheme = {
            package = pkgs.capitaine-cursors;
            name = "capitaine-cursors";
            size = 18;
          };
        };
        
        qt = with pkgs; {
          enable = true;
          platformTheme.name = "kvantum";
          style.name = "kvantum";
        };

        dconf.settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
          };
          "org/gnome/shell" = {
            disable-user-extensions = false;

            # `gnome-extensions list` for a list
            enabled-extensions = [
              "user-theme@gnome-shell-extensions.gcampax.github.com"
              "trayIconsReloaded@selfmade.pl"
              "Vitals@CoreCoding.com"
              "dash-to-panel@jderose9.github.com"
              "sound-output-device-chooser@kgshank.net"
              "space-bar@luchrioh"
            ];
          };
          "org/gnome/shell/extensions/user-theme" = {  
            name = "catppuccin-mocha-lavender-standard+normal";
          };

        };
      };
    };
}
