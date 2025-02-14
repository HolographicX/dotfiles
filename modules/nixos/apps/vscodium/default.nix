{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.vscodium;
  R-with-my-packages = pkgs.rWrapper.override{ packages = with pkgs.rPackages; [ ggplot2 languageserver httpgd]; };
in
{
  options.apps.vscodium = with types; {
    enable = mkBoolOpt false "Vscodium.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      vscodium-fhs 
      vscode
      vscode-extensions.ms-vsliveshare.vsliveshare 
      R-with-my-packages
      vscode-extensions.reditorsupport.r
    ];
  };
}