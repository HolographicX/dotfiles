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
  cfg = config.apps.alacritty;
mkLiteral = str: {
    __hm_toml_literal = true;
    __toString = _: str;
  };in {
  options.apps.alacritty = with types; {
    enable = mkBoolOpt false "Enable or disable alacritty";
  };

  config = mkIf cfg.enable {
    home.programs.alacritty = {
      enable = true;
      settings = {
        font = {
          size = 12;
          normal = ''{ family = "SpaceMono Nerd Font", style = "Regular" }'';
        };
      };
    };
  };
}