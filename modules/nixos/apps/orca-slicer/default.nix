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
  cfg = config.apps.orca-slicer;
in {
  options.apps.orca-slicer = with types; {
    enable = mkBoolOpt false "Enable or disable orca-slicer";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ orca-slicer ];
    networking.firewall = {
      enable = false;
    };

  };
}