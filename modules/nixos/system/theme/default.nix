
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

  nerdfonts = (pkgs.nerdfonts.override {
    fonts = [
      "Ubuntu"
      "UbuntuMono"
      "CascadiaCode"
      "FantasqueSansMono"
      "JetBrainsMono"
      "FiraCode"
      "Mononoki"
      "SpaceMono"
    ];
  });
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
        gnome3.adwaita-icon-theme
        adwaita-qt6
        adw-gtk3
        material-symbols
        nerdfonts
        noto-fonts
        noto-fonts-cjk-sans
        google-fonts
      ];

      home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = cursor-package;
        name = cursor-theme;
        size = 18;
      };

    home.file.".icons/default".source = "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors";

      home.extraOptions = with inputs; {
        imports = [
          catppuccin.homeManagerModules.catppuccin 
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
        ".local/share/fonts" = {
          recursive = true;
          source = "${nerdfonts}/share/fonts/truetype/NerdFonts";
        };
        ".fonts" = {
          recursive = true;
          source = "${nerdfonts}/share/fonts/truetype/NerdFonts";
        };
        ".local/share/icons/MoreWaita" = {
          source = "${moreWaita}/share/icons";
        };
      };
    };
}
