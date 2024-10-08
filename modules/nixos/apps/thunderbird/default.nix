{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.thunderbird;
in {
  options.apps.thunderbird = with types; {
    enable = mkBoolOpt false "Enable or disable thunderbird";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ thunderbird ];
  };
}