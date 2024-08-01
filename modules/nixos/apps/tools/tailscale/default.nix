{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.tools.tailscale;
in
{
  options.apps.tools.tailscale = with types; {
    enable = mkBoolOpt false "Tailscale.";
  };

  config = mkIf cfg.enable {
    services.tailscale.enable = true;
    services.tailscale.useRoutingFeatures = "client";
  };
}