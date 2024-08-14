{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.chromium;
in
{
  options.apps.chromium = with types; {
    enable = mkBoolOpt false "chromium.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ ungoogled-chromium ];
  };
}