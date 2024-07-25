{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.minecraft;
in {
  options.apps.minecraft = with types; {
    enable = mkBoolOpt false "Enable or disable jdk21 for minecraft";
  };

  config = mkIf cfg.enable {
    programs.java = { enable = true; package = pkgs.jdk21; };
  };
}