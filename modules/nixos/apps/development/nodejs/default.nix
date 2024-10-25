{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.development.nodejs;
in
{
  options.apps.development.nodejs = with types; {
    enable = mkBoolOpt false "Nodejs 22.";
  };

  config = mkIf cfg.enable {
    services.ratbagd.enable = true;
    environment.systemPackages = with pkgs; [ nodejs_22 ];
  };
}