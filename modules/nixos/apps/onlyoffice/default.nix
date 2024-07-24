{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.onlyoffice;
in
{
  options.apps.onlyoffice = with types; {
    enable = mkBoolOpt false "onlyoffice.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ onlyoffice-bin ];
  };
}