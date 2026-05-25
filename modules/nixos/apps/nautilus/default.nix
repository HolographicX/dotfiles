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
  cfg = config.apps.nautilus;
in {
  options.apps.nautilus = with types; {
    enable = mkBoolOpt false "Enable or disable nautilus";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      nautilus
    ];
  };
}