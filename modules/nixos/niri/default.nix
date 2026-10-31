{ config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.niri;
  settings = import ./_settings.nix {};
  binds = import ./_binds.nix {inherit pkgs;};
  rules = import ./_rules.nix;
  quickshellDeps = with pkgs;
  [
    accountsservice
    brightnessctl
    cava
    cliphist
    ddcutil
    elogind
    glib
    gpu-screen-recorder
    gsettings-desktop-schemas
    material-symbols
    swww
    wl-clipboard
    wget
    python3
    imagemagick
  ]
  ++ (with pkgs.kdePackages; [
    qtbase
    qtdeclarative
    qt6ct
    qtmultimedia
    qtwayland
    kirigami
  ]);

  userPackages = with pkgs; [
    matugen
    gsettings-desktop-schemas
  ];

  quickshellWrapped =
    pkgs.runCommand "quickshell-wrapped" {
      buildInputs = [pkgs.makeWrapper];
    } ''
      mkdir -p $out/bin
      paths="${pkgs.lib.makeBinPath quickshellDeps}"
      qmlPaths="${lib.makeSearchPath "lib/qt-6/qml" quickshellDeps}:${lib.makeSearchPath "lib/qt-5/qml" quickshellDeps}"


      for bin in ${pkgs.noctalia-qs}/bin/*; do
        name=$(basename "$bin")
        makeWrapper "$bin" "$out/bin/$name" \
          --prefix QML2_IMPORT_PATH : "$qmlPaths" \
          --prefix PATH : "$paths"
      done
    '';
in
{
  options.desktop.niri = with types; {
    enable = mkBoolOpt false "Enable niri";
  };
  config = mkIf cfg.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri-stable;
    };

    home.programs.niri.settings = settings // {inherit binds;} // rules;

    environment.systemPackages = with pkgs; [ quickshellWrapped ];

    services.displayManager.gdm.enable = true;
    systemd.user.services.niri-flake-polkit.enable = false;
  };
}