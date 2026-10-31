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

    environment.systemPackages = with pkgs; [ noctalia ]

    services.displayManager.gdm.enable = true;
    systemd.user.services.niri-flake-polkit.enable = false;
  };
}