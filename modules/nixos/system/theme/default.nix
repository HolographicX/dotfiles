
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
in {  
  options.system.theme = with types; {
    enable = mkBoolOpt false "Enable theme";
  };

  config =
    mkIf cfg.enable {
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      };
      home.extraOptions = {
        home.packages = [
          pkgs.capitaine-cursors
        ];
        
        home.sessionVariables = {
          XCURSOR_THEME = "capitaine-cursors";
          XCURSOR_SIZE = "18";
          HYPRCURSOR_THEME = "capitaine-cursors";
          HYPRCURSOR_SIZE = "18";
        };

        home.pointerCursor = {
          gtk.enable = true;
          x11.enable = true;
          package = pkgs.capitaine-cursors;
          name = "capitaine-cursors";
          size = 18;
        };
      };

    };
}
