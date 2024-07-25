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
    enable = mkBoolOpt false "Enable or disable minecraft";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.prismlauncher.override {
      jdks = [
        temurin-bin-21
        temurin-bin-8
        temurin-bin-17
      ];
    }];
  };
}