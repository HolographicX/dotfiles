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
  cfg = config.apps.balatro;
in {
  options.apps.balatro = with types; {
    enable = mkBoolOpt false "Enable or disable balatro";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      balatro
      balatro-mod-manager
    ];
  };
}