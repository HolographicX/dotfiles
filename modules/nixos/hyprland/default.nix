{ config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.hyprland;
in
{
  options.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable hyprland";
  };
  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
    };


    services.displayManager.gdm.enable = true;

    home.programs.illogical-impulse = {
      enable = true;

      dotfiles = {
        fish.enable = true;
        starship.enable = true;
      };

      hyprland.plugins = [
        pkgs.hyprlandPlugins.hyprexpo
      ];

    };
  };
}