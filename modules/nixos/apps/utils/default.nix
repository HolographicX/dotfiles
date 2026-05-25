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
    enable = mkBoolOpt false "rpi-imager.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      git 
      git-remote-gcrypt
      gh
    ];

    programs.nix-ld.enable = true;

    programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      glibc
    ];
  };
}