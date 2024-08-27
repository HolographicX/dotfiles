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
    programs.git = {
      enable = true;
      package = pkgs.gitFull;
      config.credential.helper = "libsecret";
    };

    programs.appimage.binfmt = true; # for appimages
    
    environment.systemPackages = with pkgs; [
      # Development
      git-remote-gcrypt
      bat
      eza
      fzf
      gnumake
      fd

      # Util
      alejandra
      vim
      wget
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
