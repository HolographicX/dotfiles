{
  lib,
  pkgs,
  siril,
  fetchFromGitLab,
  ...
}:

siril.overrideAttrs (oldAttrs: {
  version = "1.4";
  src = fetchFromGitLab {
    owner = "free-astro";
    repo = "siril";
    rev = "1.4";
    hash = "";
  };


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
