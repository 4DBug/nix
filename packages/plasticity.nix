{
  alsa-lib,
  at-spi2-atk,
  autoPatchelfHook,
  cairo,
  cups,
  dbus,
  desktop-file-utils,
  expat,
  fetchurl,
  gdk-pixbuf,
  gtk3,
  gvfs,
  hicolor-icon-theme,
  lib,
  libdrm,
  libglvnd,
  libnotify,
  libsForQt5,
  libxkbcommon,
  mesa,
  nspr,
  nss,
  openssl,
  pango,
  rpmextract,
  stdenv,
  systemd,
  trash-cli,
  vulkan-loader,
  wrapGAppsHook3,
  xdg-utils,
  xorg,
}:
stdenv.mkDerivation rec {
  pname = "plasticity";
  version = "25.2.0.beta.13";

  src = fetchurl {
    #url = "https://github.com/nkallen/plasticity/releases/download/v${version}/Plasticity-${version}-1.x86_64.rpm";
    #hash = "sha256:166f8hvgdgr5lpkff28ms5qb425b2w7ckskchsabr1nwq49f7y74";
    url = "https://github.com/4DBug/plasticity/releases/download/${version}/plasticity-beta-${version}-1.x86_64-2.rpm";
    hash = "sha256:0hqy7gw7fq49bvvpch5k5j5ax9y0z1a1wxm3jhg2w2dxlh79jrl5";
  };

  passthru.updateScript = ./update.sh;

  nativeBuildInputs = [
    wrapGAppsHook3
    autoPatchelfHook
    rpmextract
    mesa
  ];

  buildInputs = [
    alsa-lib
    at-spi2-atk
    cairo
    cups
    dbus
    desktop-file-utils
    expat
    gdk-pixbuf
    gtk3
    gvfs
    hicolor-icon-theme
    libdrm
    libnotify
    libsForQt5.kde-cli-tools
    libxkbcommon
    nspr
    nss
    openssl
    pango
    (lib.getLib stdenv.cc.cc)
    trash-cli
    xdg-utils
  ];

  runtimeDependencies = [
    systemd
    libglvnd
    vulkan-loader
    xorg.libX11
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXtst
  ];

  dontUnpack = true;

  autoPatchelfIgnoreMissingDeps = [
    "ACCAMERA.tx"
    "AcMPolygonObj15.tx"
    "ATEXT.tx"
    "ISM.tx"
    "RText.tx"
    "SCENEOE.tx"
    "TD_DbEntities.tx"
    "TD_DbIO.tx"
    "WipeOut.tx"
  ];

  installPhase = ''
    runHook preInstall

    mkdir $out
    cd $out
    rpmextract $src
    mv $out/usr/* $out
    rm -r $out/usr

    runHook postInstall
  '';

  preFixup = ''
    gappsWrapperArgs+=(--add-flags "--use-gl=egl")
  '';

  meta = with lib; {
    description = "CAD for artists";
    homepage = "https://www.plasticity.xyz";
    license = licenses.unfree;
    mainProgram = "Plasticity";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with maintainers; [ imadnyc ];
    platforms = [ "x86_64-linux" ];
  };
}
