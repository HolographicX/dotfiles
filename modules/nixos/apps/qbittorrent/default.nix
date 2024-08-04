{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.qbittorrent;
in
{
  options.apps.qbittorrent = with types; {
    enable = mkBoolOpt false "qbittorrent.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ qbittorrent ];
  };
}