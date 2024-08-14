{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.transmission;
in
{
  options.apps.transmission = with types; {
    enable = mkBoolOpt false "transmission.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ transmission_4 ];
  };
}