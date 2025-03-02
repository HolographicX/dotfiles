{
  lib,
  pkgs,
  siril,
  fetchFromGitLab,
  ...
}:

siril.overrideAttrs (oldAttrs: {
  version = "1.3.6";
  src = fetchFromGitLab {
    owner = "free-astro";
    repo = "siril";
    rev = "master";
    hash = "sha256-DYF0zoYQ/MZeTNN0GPri/GouGMmFdFliP9yekX1cBdY=";
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
