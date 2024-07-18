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
  cfg = config.desktop.addons.ollama;
in {
  options.desktop.addons.ollama = with types; {
    enable = mkBoolOpt false "Enable or disable ollama service";
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = "cuda";
    };
  };
}