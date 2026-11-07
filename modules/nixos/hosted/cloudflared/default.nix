{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hosted.cloudflared;
in {
  options.hosted.cloudflared = with types; {
    enable = mkBoolOpt false "Enable cloudflared";
  };

  config = mkIf cfg.enable {
    services.cloudflared.enable = true;
  };
} 
