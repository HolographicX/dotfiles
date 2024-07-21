{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.tailscale;
in
{
  options.apps.vscodium = with types; {
    enable = mkBoolOpt false "Tailscale.";
  };

  config = mkIf cfg.enable {
    services.tailscale.enable = true;
    services.tailscale.useRoutingFeatures = "client";
  };
}