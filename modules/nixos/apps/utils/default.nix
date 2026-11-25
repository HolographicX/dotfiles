{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.utils;
in
{
  options.apps.utils = with types; {
    enable = mkBoolOpt false "utils.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      git 
      git-remote-gcrypt
      gh
      python3
      xwayland-satellite
    ];

    programs.nix-ld.enable = true;

    programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      glibc
    ];
  };
}