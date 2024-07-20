{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.ludusavi;
in {
  options.apps.ludusavi = with types; {
    enable = mkBoolOpt false "Enable or disable ludusavi";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = [
      "com.github.mtkennerly.ludusavi"
    ];
  };
}