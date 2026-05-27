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

    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };



    services.displayManager.gdm.enable = true;

    home.programs.illogical-impulse = {
      enable = true;

      dotfiles = {
        fish.enable = true;
        starship.enable = true;
      };

      hyprland.plugins = [
        # pkgs.hyprlandPlugins.hyprexpo
      ];

    };
  };
}