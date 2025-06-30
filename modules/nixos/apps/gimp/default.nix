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
  cfg = config.apps.gimp;
in {
  options.apps.gimp = with types; {
    enable = mkBoolOpt false "Enable or disable gimp";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gimp
    ];
  };
}