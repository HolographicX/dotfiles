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
  cfg = config.apps.geeqie;
in {
  options.apps.geeqie = with types; {
    enable = mkBoolOpt false "Enable or disable geeqie";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      geeqie
    ];
  };
}