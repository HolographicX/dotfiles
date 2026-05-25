{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.tailscale;
in {
  options.apps.tailscale = with types; {
    enable = mkBoolOpt false "Enable or disable tailscale";
  };

  config = mkIf cfg.enable {
    services.tailscale.enable = true;
    services.tailscale.useRoutingFeatures = "client";
  };
}