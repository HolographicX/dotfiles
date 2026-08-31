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
  cfg = config.apps.rawtherapee;
in {
  options.apps.rawtherapee = with types; {
    enable = mkBoolOpt false "Enable or disable rawtherapee";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rawtherapee
    ];
  };
}