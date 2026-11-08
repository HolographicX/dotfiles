{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hosted.cloudflared;
in {
  options.hosted.cloudflared = with types; {
    enable = mkBoolOpt false "Enable cloudflared";
  };

  config = mkIf cfg.enable {

    sops = {
      age.keyFile = "/home/${config.user.name}/.config/sops/age/keys.txt";
      defaultSopsFile = secrets/secrets.yaml;

      secrets."cloudflared-creds" = {
        owner = "${config.user.name}";
        group = "users";
        mode = "0400";
      };
    };

    services.cloudflared = {
      enable = true;
      tunnels = {
        "4fbee666-5c78-4a4a-a5c6-4c0147d71a29" = {
          credentialsFile = "${config.sops.secrets.cloudflared-creds.path}";
          default = "http_status:404";
        };
      };
    };
  };
} 
