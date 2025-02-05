{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.common;
in {
  options.suites.common = with types; {
    enable = mkBoolOpt false "Enable the common suite";
  };

  config = mkIf cfg.enable {
    system.nix.enable = true;

    hardware.audio.enable = true;
    hardware.networking.enable = true;


    services = {
      easyeffects.enable = true;
      ssh.enable = true;
      polkit.enable = true;
      printing.enable = true;
      flatpak.enable = true;

    };
    specialisation."vfio".configuration = {
      system.nixos.tags = [ "with-vfio" ];
      environment.etc."specialisation".text = "vfio";
      apps.virt-manager.enable = true; # for vfio gpu passthrouggh
    };
    specialisation."integrated".configuration = {
      system.nixos.tags = [ "integrated" ];
      environment.etc."specialisation".text = "Integrated GPU";
      services = {
        supergfxd = {
          enable = lib.mkForce true;
          settings = {
            mode = lib.mkForce "Integrated";
          };
        };
      };
    };

    
    environment.systemPackages = [ pkgs.custom.sys ];

    system = {
      fonts.enable = true;
      locale.enable = true;
      time.enable = true;
      xkb.enable = true;
      theme.enable = true;
    };

    desktop = {
      gnome.enable = true;
      hyprland.enable = true;
    };

    # --- apps and stuff -----
    # TODO: Split apps according to suites
    apps = {
      utils.enable = true;
      utils.nix-ld.enable = true;
      firefox.enable = true;
      alacritty.enable = true;
      steam.enable = true;
      discord.enable = true;
      vscodium.enable = true;
      lutris.enable = true;
      cemu.enable = true;
      dolphin.enable = true;
      ludusavi.enable = true;
      libreoffice.enable = true;
      minecraft.enable = true;
      obsidian.enable = true;
      transmission.enable = true;
      chromium.enable = true;
      livecaptions.enable = true;
      foliate.enable = true;
      zoom.enable = true;
      tools = {
        tailscale.enable = true;
        warp.enable = true;
        piper.enable = true;
      };

      # design
      blender.enable = true;
      siril.enable = true;
      shotwell.enable = true;
      orca-slicer.enable = true;
      kicad.enable = true;
      rawtherapee.enable = true;
      
      # dev
      development = {
          nodejs.enable = true;
          android.enable = true;
      };
      arduino.enable = true;

    };
  };
}
