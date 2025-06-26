{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.cuda;
in
{
  options.apps.cuda = with types; {
    enable = mkBoolOpt false "chromium.";
  };

  config = mkIf cfg.enable {
    nix.settings.substituters = [
      "https://nix-community.cachix.org"
    ];
    nix.settings.trusted-public-keys = [
      # Compare to the key published at https://nix-community.org/cache
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
      nixpkgs.config.cudaSupport = true;
    nixpkgs.config.allowUnfreePredicate =
      p:
      builtins.all (
        license:
        license.free
        || builtins.elem license.shortName [
          "CUDA EULA"
          "cuDNN EULA"
          "cuTENSOR EULA"
          "NVidia OptiX EULA"
        ]
      ) (if builtins.isList p.meta.license then p.meta.license else [ p.meta.license ]);
  };
}