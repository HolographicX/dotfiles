{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.shell;
in {
  options.system.shell = with types; {
    shell = mkOpt (enum ["nushell" "fish"]) "fish" "What shell to use";
  };

  config = {
    environment.systemPackages = with pkgs; [
      eza
      bat
      nitch
      zoxide
      starship
    ];
    users.defaultUserShell = pkgs.${cfg.shell};
    users.users.root.shell = pkgs.bashInteractive;
    users.users.${config.user.name}.ignoreShellProgramCheck = true;
    home.programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };

    environment.shellAliases = {
      ".." = "cd ..";
      neofetch = "nitch";
    };

    home.programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    home.programs.fish = {
      enable = true;
      catppuccin.enable = true;
      shellAliases = {
        ls = "eza -G --icons --no-user --no-time --git -s type";
        cat = "bat";
      };
      shellInit = ''
        zoxide init fish | source
        set -g fish_greeting
        if status --is-interactive
          keychain --eval --quiet -Q id_rsa | source
        end

        function , --description 'add software to shell session'
              nix shell nixpkgs#$argv[1..-1]
        end
      '';
    };
  };
}
