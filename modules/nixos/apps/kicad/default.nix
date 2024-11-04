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
  cfg = config.apps.kicad;

  kicadWrapped = pkgs.symlinkJoin {
    name = "kicad";
    paths = [ pkgs.kicad ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/kicad --set GTK_THEME Adw-gtk3-dark
    '';
  };
in {
  options.apps.kicad = with types; {
    enable = mkBoolOpt false "Enable or disable kicad";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ kicadWrapped ];
    
  };
}