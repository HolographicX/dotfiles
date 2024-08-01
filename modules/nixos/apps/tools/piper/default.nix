{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.libreoffice;
in
{
  options.apps.libreoffice = with types; {
    enable = mkBoolOpt false "libreoffice.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ piper ];
  };
}