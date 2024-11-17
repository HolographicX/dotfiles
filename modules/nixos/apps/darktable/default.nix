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
  cfg = config.apps.darktable;
in {
  options.apps.darktable = with types; {
    enable = mkBoolOpt false "Enable or disable darktable";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      darktable
    ];
  };
}