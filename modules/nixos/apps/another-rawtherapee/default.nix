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
  cfg = config.apps.another-rawtherapee;
in {
  options.apps.another-rawtherapee = with types; {
    enable = mkBoolOpt false "Enable or disable another rawtherapee";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      art
    ];
  };
}