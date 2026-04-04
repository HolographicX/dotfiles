{
  lib,
  pkgs,
  siril,
  fetchFromGitLab,
  ...
}:

let
  fhs = pkgs.buildFHSEnv {
    name = "siril-fhs";
    targetPkgs = pkgs: with pkgs; [
      python3
      python3Packages.pip
      python3Packages.virtualenv
      gcc
      glibc
      zlib
      libjpeg
      libpng
      libtiff
      fftwFloat
      opencv
      curl
      git
    ];
    runScript = "bash -c \"$@\"";
  };
in
siril.overrideAttrs (oldAttrs: {
  pname = "siril";
  version = "unstable";

  doInstallCheck = false;
  src = fetchFromGitLab {
    owner = "free-astro";
    repo = "siril";
    rev = "master";
    hash = "sha256-nuezn8pRxeZvdCFA3QjjUsQJwfHAXFUl5ClrLT9lhDs=";
  };

  nativeBuildInputs = with pkgs; [
    meson
    ninja
    cmake
    pkg-config
    git
    criterion
    wrapGAppsHook3
    stdenv.cc
  ];


  buildInputs = with pkgs; [
    gtk3
    cfitsio
    gsl
    exiv2
    gnuplot
    gtksourceview4
    opencv
    fftwFloat
    librtprocess
    wcslib
    libconfig
    libraw
    libtiff
    libpng
    libgit2
    libjpeg
    libjxl
    libheif
    libxisf
    ffms
    ffmpeg
    json-glib
    curl
    yyjson
    sqlite
  ];

  propagatedBuildInputs = with pkgs; [ python3 fontconfig ];
  preConfigure = ''
    export FONTCONFIG_FILE=${pkgs.fontconfig.out}/etc/fonts/fonts.conf
    export FONTCONFIG_PATH=${pkgs.fontconfig.out}/etc/fonts
    export XDG_CACHE_HOME=\$${XDG_CACHE_HOME:-\$HOME/.cache}
    mkdir -p $XDG_CACHE_HOME
  '';
  
  # Necessary because project uses default build dir for flatpaks/snaps
  mesonBuildDir = "nixbld";

  postInstall = ''
    mv $out/bin/siril $out/bin/siril-real

    if [ -f $out/bin/siril-cli ]; then
      mv $out/bin/siril-cli $out/bin/siril-cli-real
    fi

    cat > $out/bin/siril <<EOF
  #!${pkgs.runtimeShell}

  export FONTCONFIG_FILE=${pkgs.fontconfig.out}/etc/fonts/fonts.conf
  export FONTCONFIG_PATH=${pkgs.fontconfig.out}/etc/fonts
  export XDG_CACHE_HOME=\$HOME/.cache

  exec ${fhs}/bin/siril-fhs "$out/bin/siril-real" "\$@"
  EOF

    chmod +x $out/bin/siril

    if [ -f $out/bin/siril-cli-real ]; then
      cat > $out/bin/siril-cli <<EOF
  #!${pkgs.runtimeShell}

  export FONTCONFIG_FILE=${pkgs.fontconfig.out}/etc/fonts/fonts.conf
  export FONTCONFIG_PATH=${pkgs.fontconfig.out}/etc/fonts
  export XDG_CACHE_HOME=\$HOME/.cache

  exec ${fhs}/bin/siril-fhs "$out/bin/siril-cli-real" "\$@"
  EOF
      chmod +x $out/bin/siril-cli
    fi
  '';  
  meta = {
    mainProgram = "siril";
    homepage = "https://www.siril.org/";
    description = "Astrophotographic image processing tool";
    changelog = "https://gitlab.com/free-astro/siril/-/blob/HEAD/ChangeLog";
  };

})
