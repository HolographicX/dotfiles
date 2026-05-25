{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.user;
  defaultIconFileName = "profile.png";
  defaultIcon = pkgs.stdenvNoCC.mkDerivation {
    name = "default-icon";
    src = ./. + "/${defaultIconFileName}";

    dontUnpack = true;

    installPhase = ''
      cp $src $out
    '';

    passthru = {fileName = defaultIconFileName;};
  };
  propagatedIcon =
    pkgs.runCommand "propagated-icon"
    {passthru = {inherit (cfg.icon) fileName;};}
    ''
      local target="$out/share/icons/user/${cfg.name}"
      mkdir -p "$target"

      cp ${cfg.icon} "$target/${cfg.icon.fileName}"
    '';
in {

  options.user = with types; {
    name = mkOpt str "holographic" "The name to use for the user account.";
    hashedPassword =
      mkOpt str "$6$7MLlJuQPNHFE4nUV$wa1NqDt6LnE7I9SXzvNswoYLTtD/d8KWulYA3LQDbeV0tVWHhbDg/u0bMLUAZASn9fPjddfOmUaLTORU5bC.51" "The password for the user account as a hash.";

    icon =
      mkOpt (nullOr package) defaultIcon
      "The profile picture to use for the user.";
    extraGroups = mkOpt (listOf str) [] "Groups for the user to be assigned.";
    extraOptions =
      mkOpt attrs {}
      "Extra options passed to <option>users.users.<name></option>.";
  };


  config = {
    snowfallorg.users.${cfg.name} = {
      create = true;
    };

    environment.systemPackages = with pkgs; [
      propagatedIcon
    ];

    environment.sessionVariables.FLAKE = "/home/${cfg.name}/.dots";

    home = {
      file = {
        ".face".source = cfg.icon;
        "Pictures/${
          cfg.icon.fileName or (builtins.baseNameOf cfg.icon)
        }".source =
          cfg.icon;
      };
    };

    users.users.${cfg.name} =
      {
        isNormalUser = true;
        inherit (cfg) name hashedPassword;
        home = "/home/${cfg.name}";
        group = "users";

        extraGroups =
          ["wheel" "audio" "sound" "video" "networkmanager" "input" "tty" "docker" "dialout" "uucp"]
          ++ cfg.extraGroups;
      }
      // cfg.extraOptions;
  };
}
