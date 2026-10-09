{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-26.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        snowfall-lib = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-hardware = {
          url = "github:NixOS/nixos-hardware";
          inputs.nixpkgs.follows = "nixpkgs";
        };


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
          url = "github:nix-community/stylix/release-26.05";
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

        nixConfig = {
            extra-substituters = [
              "https://nixos.org"
              "https://cache.nixos-cuda.org"
              "https://hyprland.cachix.org"
            ];
            extra-trusted-substituters = [
              "https://hyprland.cachix.org"
            ];
            extra-trusted-public-keys = [
              "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
              "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
              "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
            ];
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