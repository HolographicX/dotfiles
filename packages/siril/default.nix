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
      python312
      python312Packages.pip
      python312Packages.virtualenv
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
      cudaPackages.cudatoolkit
      cudaPackages.cudnn
      mesa
      libglvnd

      libX11
      libXext
      libXrender
      libXi
      libXrandr
      libxcb
      libxkbcommon

      fontconfig
      freetype
      glib
      bzip2
      brotli
      zstd
      dbus
      cups
      xcb-util-cursor
      pkgs.xcbutil
      pkgs.xcbutilwm
      pkgs.xcbutilimage
      pkgs.xcbutilkeysyms
      pkgs.xcbutilrenderutil
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
    hash = "sha256-3ZDUzg2JFjz2z+LUkYgf7MqCNYAL8Msi7rkq7EoFyis=";
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

  propagatedBuildInputs = with pkgs; [ python312 fontconfig ];
  preConfigure = ''
    export FONTCONFIG_FILE=${pkgs.fontconfig.out}/etc/fonts/fonts.conf
    export FONTCONFIG_PATH=${pkgs.fontconfig.out}/etc/fonts
    export XDG_CACHE_HOME=$TMPDIR/fontcache
    mkdir -p $XDG_CACHE_HOME
  '';
  
  mesonBuildDir = "nixbld";

postInstall = ''
  # Rename original binaries
  mv $out/bin/siril $out/bin/siril-real

  if [ -f $out/bin/siril-cli ]; then
    mv $out/bin/siril-cli $out/bin/siril-cli-real
  fi

  # Create wrapper for siril
  cat > $out/bin/siril <<EOF
#!${pkgs.runtimeShell}

export QT_QPA_PLATFORM=xcb
export QT_PLUGIN_PATH=${pkgs.qt6.qtbase}/lib/qt-6/plugins
export QT_QPA_PLATFORM_PLUGIN_PATH=${pkgs.qt6.qtbase}/lib/qt-6/plugins/platforms

export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
  pkgs.stdenv.cc.cc.lib
  pkgs.zlib
  pkgs.bzip2
  pkgs.brotli
  pkgs.libjpeg
  pkgs.libpng
  pkgs.libtiff
  pkgs.fftwFloat
  pkgs.opencv
  pkgs.glibc
  pkgs.cudaPackages.cudatoolkit
  pkgs.cudaPackages.cudnn
  pkgs.mesa
  pkgs.libglvnd

  pkgs.libX11
  pkgs.libXext
  pkgs.libXrender
  pkgs.libXi
  pkgs.libXrandr
  pkgs.libxcb
  pkgs.libxkbcommon
  pkgs.dbus
  pkgs.cups

  pkgs.fontconfig
  pkgs.freetype
  pkgs.glib
  pkgs.zstd
  pkgs.xcb-util-cursor
  pkgs.xcbutil
  pkgs.xcbutilwm
  pkgs.xcbutilimage
  pkgs.xcbutilkeysyms
  pkgs.xcbutilrenderutil

  ]}

export LD_PRELOAD=${pkgs.stdenv.cc.cc.lib}/lib/libstdc++.so.6

exec ${fhs}/bin/siril-fhs "$out/bin/siril-real" "\$@"
EOF

  chmod +x $out/bin/siril

  # Create wrapper for siril-cli if present
  if [ -f $out/bin/siril-cli-real ]; then
    cat > $out/bin/siril-cli <<EOF
#!${pkgs.runtimeShell}

export QT_QPA_PLATFORM=xcb
export QT_PLUGIN_PATH=${pkgs.qt6.qtbase}/lib/qt-6/plugins
export QT_QPA_PLATFORM_PLUGIN_PATH=${pkgs.qt6.qtbase}/lib/qt-6/plugins/platforms

export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
  pkgs.stdenv.cc.cc.lib
  pkgs.zlib
  pkgs.bzip2
  pkgs.brotli
  pkgs.libjpeg
  pkgs.libpng
  pkgs.libtiff
  pkgs.fftwFloat
  pkgs.opencv
  pkgs.glibc
  pkgs.cudaPackages.cudatoolkit
  pkgs.cudaPackages.cudnn
  pkgs.mesa
  pkgs.libglvnd

  pkgs.libX11
  pkgs.libXext
  pkgs.libXrender
  pkgs.libXi
  pkgs.libXrandr
  pkgs.libxcb
  pkgs.libxkbcommon
  pkgs.dbus
  pkgs.cups
  pkgs.fontconfig
  pkgs.freetype
  pkgs.glib
  pkgs.zstd
  pkgs.xcb-util-cursor
  pkgs.xcbutil
  pkgs.xcbutilwm
  pkgs.xcbutilimage
  pkgs.xcbutilkeysyms
  pkgs.xcbutilrenderutil

]}

export LD_PRELOAD=${pkgs.stdenv.cc.cc.lib}/lib/libstdc++.so.6

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
