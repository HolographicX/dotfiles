{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-25.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        snowfall-lib = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";

        dotfiles = {
          url = "git+https://github.com/holographicx/dots-hyprland?submodules=1";
          flake = false;
        };

        illogical-flake = {
          url = "github:holographicx/illogical-flake";
          inputs.nixpkgs.follows = "nixpkgs";
          inputs.dotfiles.follows = "dotfiles";
        };

        hyprland.url = "github:hyprwm/Hyprland";
        hyprland-plugins = {
          url = "github:hyprwm/hyprland-plugins";
          inputs.hyprland.follows = "hyprland";
        };

        blender-bin.url = "github:edolstra/nix-warez?dir=blender";

        stylix = {
          url = "github:nix-community/stylix/release-25.11";
          inputs.nixpkgs.follows = "nixpkgs";
        };

    };

    outputs = inputs:
    inputs.snowfall-lib.mkFlake {
        inherit inputs;
        src = ./.;
        snowfall = {
          meta = {
            name = "dotfiles";
            title = "dotfiles";
          };

          namespace = "custom";
        };

        channels-config = {
          allowUnfree = true;
        };

        overlays = with inputs; [
          blender-bin.overlays.default
        ];

        homes.modules = with inputs; [
          illogical-flake.homeManagerModules.default
        ];

        systems.modules.nixos = with inputs; [
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
        ];

        systems.hosts.holographic.modules = with inputs; [
          nixos-hardware.nixosModules.asus-zephyrus-gu603h
        ];
    };
}