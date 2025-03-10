{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.docker;
in
{
  options.apps.docker = with types; {
    enable = mkBoolOpt false "docker.";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.users.${config.user.name}.extraGroups = [ "docker" ];
  };
}