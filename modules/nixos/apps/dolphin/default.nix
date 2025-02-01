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
  cfg = config.apps.dolphin;
in {
  options.apps.dolphin = with types; {
    enable = mkBoolOpt false "Enable or disable dolphin";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dolphin-emu
    ];
  };
}