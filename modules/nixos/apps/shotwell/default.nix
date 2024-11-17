{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.shotwell;
in {
  options.apps.shotwell = with types; {
    enable = mkBoolOpt false "Enable or disable shotwell";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      shotwell
    ];
  };
}