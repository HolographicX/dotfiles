{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.livecaptions;
in {
  options.apps.livecaptions = with types; {
    enable = mkBoolOpt false "Enable or disable livecaptions";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      livecaptions
    ];
  };
}