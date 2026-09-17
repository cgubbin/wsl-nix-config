# configuration.nix, or wherever your system package list lives
{
  config,
  pkgs,
  lib,
  ...
}: let
  weztermMatched = pkgs.stdenv.mkDerivation rec {
    pname = "wezterm";
    version = "20240203-110809-5046fc22";
    src = pkgs.fetchurl {
      url = "https://github.com/wez/wezterm/releases/download/${version}/<exact-asset-filename>";
      sha256 = "sha256-Az+HlnK/lRJpUSGm5UKyma1l2PaBKNCGFiaYnLECMX8=";
    };
    nativeBuildInputs = [pkgs.autoPatchelfHook];
    buildInputs = [
      pkgs.stdenv.cc.cc.lib
      pkgs.zlib
      pkgs.expat
      pkgs.openssl
      pkgs.fontconfig
      pkgs.libxkbcommon
      pkgs.xorg.libX11
      pkgs.xorg.libxcb
    ];
    installPhase = ''
      mkdir -p $out
      cp -r . $out/
    '';
  };
in {
  environment.systemPackages = [
    weztermMatched
  ];
}
