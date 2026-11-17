{ pkgs, ... }:
let
  # Official EDRLab build: includes the proprietary LCP module that
  # source builds (nixpkgs thorium-reader) lack.
  thorium = pkgs.appimageTools.wrapType2 rec {
    pname = "thorium";
    version = "3.5.1";
    src = pkgs.fetchurl {
      url = "https://github.com/edrlab/thorium-reader/releases/download/v${version}/Thorium-${version}-x86_64.AppImage";
      hash = "sha256-kGZ11RgZek6I7/HTSYGNsh5Jx5eYBsMltS4w4x3SIxI=";
    };
    extraInstallCommands =
      let
        contents = pkgs.appimageTools.extract { inherit pname version src; };
      in
      ''
        install -Dm444 ${contents}/thorium.desktop -t $out/share/applications
        substituteInPlace $out/share/applications/thorium.desktop \
          --replace-fail 'Exec=AppRun --no-sandbox' 'Exec=thorium'
        install -Dm444 ${contents}/thorium.png -t $out/share/icons/hicolor/512x512/apps
      '';
  };
in
{
  home.packages = [ pkgs.calibre thorium ];
}
