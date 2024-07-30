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
  cfg = config.desktop.addons.fuzzel;
in {
  options.desktop.addons.fuzzel = with types; {
    enable = mkBoolOpt false "Enable or disable anyrun";
  };

  config = mkIf cfg.enable {
    home.extraOptions.programs.fuzzel.enable = true;
    home.configFile."fuzzel" = {
      source = ../../.config/fuzzel;
      recursive = true;
    };
  };
}