{
  lib,
  pkgs,
  siril,
  fetchFromGitLab,
  ...
}:
let
  version = "master";
in
siril.overrideAttrs (oldAttrs: {
  version = version;
  src = fetchFromGitLab {
    owner = "free-astro";
    repo = "siril";
    rev = version;
    hash = "sha256-2kFNUN8zY1Ll/gzmWdosrtVwVoiZtQYIELjT4n3gJmM=";
  };


  # src = "${inputs.bibata-cursors}";

  buildInputs = with pkgs; [
    gtk3
    cfitsio
    gsl
    exiv2
    gnuplot
    opencv
    fftwFloat
    librtprocess
    wcslib
    libconfig
    libraw
    libtiff
    libpng
    libjpeg
    libheif
    ffms
    ffmpeg
    json-glib
    curl
    libjxl
    libxisf
    libgit2
    yyjson
    gtksourceview4
  ];

  configureScript = ''
    ${pkgs.meson}/bin/meson setup --buildtype release nixbld .
  '';
})
