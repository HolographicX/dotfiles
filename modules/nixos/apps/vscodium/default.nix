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
    enable = mkBoolOpt false "Discord.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ vscodium ];
  };
}