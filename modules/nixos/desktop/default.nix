{
  options,
  config,
  lib,
  inputs,
  ...
}:
{
  config = {
    home.configFile = {
      "ags".source = ./.config/ags;
      "fuzzel".source = ./.config/fuzzel;
    };
  };
}
