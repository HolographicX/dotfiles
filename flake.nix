{
  description = "";

  inputs = {
    # Core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    catppuccin.url = "github:catppuccin/nix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils-plus.url = "github:fl42v/flake-utils-plus";
    };
    nix-colors.url = "github:misterio77/nix-colors";

    more-waita = {
      url = "github:somepaulo/MoreWaita";
      flake = false;
    };
    ags.url = "github:Aylur/ags";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;

      snowfall = {
        meta = {
          name = "dotfiles";
          title = "dotfiles";
        };

        namespace = "custom";
      };
    };
  in
    lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        allowUnfree = true;
      };
      systems.hosts.soham.modules = with inputs; [
        nixos-hardware.nixosModules.asus-zephyrus-gu603h
      ];

      overlays = with inputs; [];

      systems.modules.nixos = with inputs; [
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        nix-flatpak.nixosModules.nix-flatpak
      ];

      templates = import ./templates {};
    };
}
