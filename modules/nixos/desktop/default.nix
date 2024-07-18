{
  options,
  config,
  lib,
  inputs,
  impurity,
  ...
}:
{
  config = {
    home.configFile = let link = impurity.link; in {
      "ags".source = link ./.config/ags;
      "foot".source = link ./.config/foot;
      "fuzzel".source = link ./.config/fuzzel;
      "mpv".source = link ./.config/mpv;
      "".source = link ./.config/mpv;
    };
  };
}
