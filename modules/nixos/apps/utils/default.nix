{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.utils;
in {
  options.apps.utils = with types; {
    enable = mkBoolOpt false "Enable or disable utils apps";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Development
      git
      git-remote-gcrypt
      bat
      eza
      fzf
      fd

      # Util
      alejandra
      unzip
      sshfs
      htop
      ffmpeg
      python3
      neofetch
      pciutils
    ];
  };
}
