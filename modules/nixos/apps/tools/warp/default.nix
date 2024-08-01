{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.tools.warp;
in
{
  options.apps.tools.warp = with types; {
    enable = mkBoolOpt false "Cloudflare Warp.";
  };

  config = mkIf cfg.enable {
    services.cloudflare-warp = {
      enable = true;
    };
  };
}