{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.zen;
in {
  options.apps.zen = with types; {
    enable = mkBoolOpt false "Enable or disable zen browser";
  };

  config = mkIf cfg.enable {
    home = {
      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;
      };
    };    
  };
}