{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.bt;
in {
  options.hardware.bt = with types; {
    enable = mkBoolOpt false "Enable networking";
  };

  config = mkIf cfg.enable {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;

        settings = {
          General = {
            Experimental = true;
          };

          Policy = {
            AutoEnable = true;
          };
        };
      };

      services.blueman.enable = true;
  };
}
