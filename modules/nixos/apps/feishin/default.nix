{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.firefox;
in {
  options.apps.firefox = with types; {
    enable = mkBoolOpt false "Enable or disable firefox browser";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.feishin ];
  };
}