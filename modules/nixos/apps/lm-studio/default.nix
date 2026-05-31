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
  cfg = config.apps.lmstudio;
in {
  options.apps.lmstudio = with types; {
    enable = mkBoolOpt false "Enable or disable lmstudio";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lmstudio
    ];

    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };

  };
}