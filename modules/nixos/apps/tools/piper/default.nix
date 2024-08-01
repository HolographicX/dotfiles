{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.tools.piper;
in
{
  options.apps.tools.piper = with types; {
    enable = mkBoolOpt false "Piper gtk mouse.";
  };

  config = mkIf cfg.enable {
    services.ratbagd.enable = true;
    environment.systemPackages = with pkgs; [ piper ];
  };
}