{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.orca-slicer;
in
{
  options.apps.orca-slicer = with types; {
    enable = mkBoolOpt false "Enable or disable Orca Slicer.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      orca-slicer 
    ];
  };
}