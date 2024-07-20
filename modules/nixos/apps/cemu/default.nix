{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.cemu;
in {
  options.apps.cemu = with types; {
    enable = mkBoolOpt false "Enable or disable cemu";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cemu
    ];
  };
}