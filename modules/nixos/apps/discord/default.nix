{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.discord;
in
{
  options.apps.discord = with types; {
    enable = mkBoolOpt false "Discord.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ vesktop ];
  };
}