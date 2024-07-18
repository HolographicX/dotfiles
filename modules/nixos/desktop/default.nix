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
      # "ags".source = link ./.config/ags;
      "fuzzel".source = ./.config/fuzzel;
    };
  };
}
