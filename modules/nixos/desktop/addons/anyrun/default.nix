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
  cfg = config.desktop.addons.anyrun;
in {
  options.desktop.addons.anyrun = with types; {
    enable = mkBoolOpt false "Enable or disable anyrun";
  };

  config = mkIf cfg.enable {
    home = {

      extraOptions = {
        imports = [
          inputs.anyrun.homeManagerModules.default
        ];
      };

      programs.anyrun = {
        enable = true;
        config = {
          plugins = with inputs.anyrun.packages.${pkgs.system}; [
            applications
            randr
            rink
            shell
            symbols
          ];

          width.fraction = 0.3;
          y.absolute = 15;
          hidePluginInfo = true;
          closeOnClick = true;
        };
      };
    };
  };
}