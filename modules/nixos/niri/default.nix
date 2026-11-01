{ config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.niri;
  settings = import ./_settings.nix {};
  binds = import ./_binds.nix {inherit pkgs;};
  rules = import ./_rules.nix;
in
{
  options.desktop.niri = with types; {
    enable = mkBoolOpt false "Enable niri";
  };
  config = mkIf cfg.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri-stable;
    };

    home.programs.niri.settings = settings // {inherit binds;} // rules;

    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = {
        cursor = {
          theme = "pkgs.capitaine-cursors";
          size = 18;
          path = pkgs.capitaine-cursors;
        };
      };
    };
    
    home.programs.noctalia = {
      enable = true;
      settings = {
        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Catppuccin";
        };
        wallpaper = {
          enabled = true;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
    ];

    systemd.user.services.niri-flake-polkit.enable = false;
  };
}