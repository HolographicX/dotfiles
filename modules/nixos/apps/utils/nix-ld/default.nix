{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.utils.nix-ld;
in {
  options.apps.utils.nix-ld = with types; {
    enable = mkBoolOpt false "Enable or disable nix-ld";
  };

  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;

    programs.nix-ld.libraries = with pkgs; [

      # Add any missing dynamic libraries for unpackaged programs

      # here, NOT in environment.systemPackages

    ];  
  };
}

