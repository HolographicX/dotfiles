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
        publicKey = "AAAAC3NzaC1lZDI1NTE5AAAAIP/IjN2C3y2CKNmVxRUyYPxSYDluf628pHnA2/i/nv9m";
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
      identityfile ~/.ssh/key 
    '';

    programs.ssh.startAgent = true;
    programs.gnupg.agent.enable = true;

  };
}
