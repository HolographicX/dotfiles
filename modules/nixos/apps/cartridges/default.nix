{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.cartridges;
in {
  options.apps.cartridges = with types; {
    enable = mkBoolOpt false "Enable or disable cartridges";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cartridges
    ];
  };
}