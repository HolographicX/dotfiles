
{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.theme;
  moreWaita = pkgs.stdenv.mkDerivation {
    name = "MoreWaita";
    src = inputs.more-waita;
    installPhase = ''
      mkdir -p $out/share/icons
      mv * $out/share/icons
    '';
  };
  moreWaitaIcons = {
    ".local/share/icons/MoreWaita" = {
      source = "${moreWaita}/share/icons";
    };
  };

  google-fonts = (pkgs.google-fonts.override {
    fonts = [
      # Sans
      "Gabarito" "Lexend"
      # Serif
      "Chakra Petch" "Crimson Text"
    ];
  });
  cursor-package = pkgs.capitaine-cursors;
  cursor-theme = "capitaine-cursors";
  nerdfonts = [
    pkgs.nerd-fonts.ubuntu
    pkgs.nerd-fonts.ubuntu-mono
    pkgs.cascadia-code
    pkgs.nerd-fonts.fantasque-sans-mono
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.mononoki
    pkgs.nerd-fonts.space-mono
  ];

in {  
  options.system.theme = with types; {
    enable = mkBoolOpt false "Enable theme";
  };

  config =
    mkIf cfg.enable {
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };
      environment.systemPackages = with pkgs; [
        adwaita-icon-theme
        adwaita-qt6
        adw-gtk3
        material-symbols
        noto-fonts
        noto-fonts-cjk-sans
        google-fonts

        nerd-fonts.ubuntu
        nerd-fonts.ubuntu-mono
        cascadia-code
        nerd-fonts.fantasque-sans-mono
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
        nerd-fonts.mononoki
        nerd-fonts.space-mono
      ];

      home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = cursor-package;
        name = cursor-theme;
        size = 18;
      };

      home.extraOptions = with inputs; {
        imports = [
          catppuccin.homeModules.catppuccin 
        ];
        catppuccin = {
          accent = "lavender";
          enable = true;
          flavor = "mocha";
        };

        gtk = {
          enable = true;
          catppuccin.enable = true;
          iconTheme.name = moreWaita.name;
          gtk3.extraCss = ''
            headerbar, .titlebar,
            .csd:not(.popup):not(tooltip):not(messagedialog) decoration{
              border-radius: 0;
            }
          '';
          font = {
            name = "Rubik";
            package = pkgs.google-fonts.override { fonts = [ "Rubik" ]; };
            size = 11;
          };
        };
        
        qt = {
          enable = true;
          platformTheme.name = "kvantum";
          style.name = "kvantum";
        };
      };

      home.file = {
        ".local/share/icons/MoreWaita" = {
          source = "${moreWaita}/share/icons";
        };
      };
    };
}
