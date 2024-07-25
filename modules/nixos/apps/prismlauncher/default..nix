{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.prismlauncher;
in {
  options.apps.prismlauncher = with types; {
    enable = mkBoolOpt false "Enable or disable prismlauncher";
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