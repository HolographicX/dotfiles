{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.vesktop;
in
{
  options.apps.vesktop = with types; {
    enable = mkBoolOpt false "Vesktop.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      vesktop
    ];
  };
}