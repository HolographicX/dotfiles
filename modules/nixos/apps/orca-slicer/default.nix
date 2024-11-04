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
      allowedTCPPorts = [ 8883 990 322 6000 123 ];
      allowedTCPPortRanges = [
        { from = 50000; to = 50100; }
      ];
    };
  };
}