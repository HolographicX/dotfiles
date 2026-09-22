{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.services.ssh;
in {
  options.services.ssh = with types; {
    enable = mkBoolOpt false "Enable ssh";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [22];
      settings.PermitRootLogin = "prohibit-password";
      allowSFTP = true;
    };

    users.users = let 
        publicKey = "AAAAC3NzaC1lZDI1NTE5AAAAIEy114E9KBCLE5Ooilm2XY+oV8YkelTg8jyxsGBVpQXT";
    in
    {
      root.openssh.authorizedKeys.keys = [
        publicKey
      ];
      ${config.user.name}.openssh.authorizedKeys.keys = [
        publicKey
      ];
    };

    home.file.".ssh/config".text = ''
      Host *
        IdentityFile ~/.ssh/key
        AddKeysToAgent yes
    '';

    programs.ssh.startAgent = true;

  };
}
