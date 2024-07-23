{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.vscodium;
in
{
  options.apps.vscodium = with types; {
    enable = mkBoolOpt false "Vscodium.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ onlyoffice-bin ];
  };
}