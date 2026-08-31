{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.heroic;
in
{
  options.apps.heroic = with types; {
    enable = mkBoolOpt false "heroic.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      heroic
    ];
  };
}