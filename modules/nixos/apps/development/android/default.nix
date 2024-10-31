{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.development.android;
in
{
  options.apps.development.android = with types; {
    enable = mkBoolOpt false "android studio.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ android-studio ];
  };
}