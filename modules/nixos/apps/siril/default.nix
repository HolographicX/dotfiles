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
  cfg = config.apps.siril;
in {
  options.apps.siril = with types; {
    enable = mkBoolOpt false "Enable or disable another siril";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      siril
    ];
  };
}