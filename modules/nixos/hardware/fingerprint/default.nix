{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.fingerprint;
in {
  options.hardware.fingerprint = with types; {
    enable = mkBoolOpt false "Enable fingerprint sensor";
  };

  config = mkIf cfg.enable {
    services.fprintd.enable = true;
  };
}
