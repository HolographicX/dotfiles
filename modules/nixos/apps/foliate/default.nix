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
  cfg = config.apps.foliate;
in {
  options.apps.foliate = with types; {
    enable = mkBoolOpt false "Enable or disable foliate";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      foliate
    ];
  };
}