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
  cfg = config.apps.feishin;
in {
  options.apps.feishin = with types; {
    enable = mkBoolOpt false "Enable or disable kicad";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ feishin ];
    
  };
}