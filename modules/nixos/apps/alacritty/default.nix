{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.alacritty;
in {
  options.apps.alacritty = with types; {
    enable = mkBoolOpt false "Enable or disable alacritty";
  };

  config = mkIf cfg.enable {
    home.programs.alacritty = {
      enable = true;
      settings = {
        font.size = 12;
      };
    };
  };
}