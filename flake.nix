{
  description = "";

  inputs = {
    # Core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
      systems.hosts.soham.modules = with inputs; [];

      overlays = with inputs; [];

      systems.modules.nixos = with inputs; [
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
      ];

      templates = import ./templates {};
    };
}
