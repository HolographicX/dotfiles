{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.luminanceHDR;
in {
  options.apps.luminanceHDR = with types; {
    enable = mkBoolOpt false "Enable or disable luminanceHDR";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = [
      "net.sourceforge.qtpfsgui.LuminanceHDR"
    ];
  };
}