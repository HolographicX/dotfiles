{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.opencode;
in
{
  options.apps.opencode = with types; {
    enable = mkBoolOpt false "opencode.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      opencode 
    ];
  };
}