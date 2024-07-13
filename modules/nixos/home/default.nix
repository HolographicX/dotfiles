{
  options,
  config,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; {
  imports = with inputs; [];

  options.home = with types; {
    file =
      mkOpt attrs {}
      "A set of files to be managed by home-manager's <option>home.file</option>.";


    configFile =
      mkOpt attrs {}
      "A set of files to be managed by home-manager's <option>xdg.configFile</option>.";


    programs = mkOpt attrs {} "Programs to be managed by home-manager.";


    extraOptions = mkOpt attrs {} "Options to pass directly to home-manager.";
  };

  config = with inputs; {
    home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.home.configFile;
      programs = mkAliasDefinitions options.home.programs;
    };

    home-manager = with inputs; {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit nix-colors;};
      users.${config.user.name} =
        mkAliasDefinitions options.home.extraOptions;
    };

  };
}
