{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.g14;
in {
  options.system.g14 = with types; {
    enable = mkBoolOpt false "Whether or not to enable g14 packages.";
  };
  
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      supergfxctl
      asusctl
    ];

    services.supergfxd.enable = true;
    services = {
        asusd = {
          enable = true;
          enableUserService = true;
        };
    };
  };
}