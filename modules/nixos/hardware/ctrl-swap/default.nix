{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.ctrl-swap;
in {
  options.hardware.ctrl-swap = with types; {
    enable = mkBoolOpt false "Whether or not to enable ctrl and fn swap.";
  };

  config = mkIf cfg.enable {
    services.keyd = {
      enable = true;
      keyboards.default.settings = {
        main = {
          leftcontrol = "fn";
          fn = "leftcontrol";
        };
      };
    };
  };
}
