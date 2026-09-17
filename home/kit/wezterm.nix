# configuration.nix, or wherever your system package list lives
{
  config,
  pkgs,
  lib,
  ...
}: let
  weztermMatched = pkgs.stdenv.mkDerivation rec {
    pname = "wezterm";
    version = "nightly";
    src = pkgs.fetchurl {
      url = "https://github.com/wezterm/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu24.04.deb";
      sha256 = "sha256-AWSWdPoEzo/0JrqIIwzKKgiVatIJh+MLpqg3FZpNDBo=";
    };
    nativeBuildInputs = [pkgs.autoPatchelfHook pkgs.dpkg];
    buildInputs = [
      pkgs.stdenv.cc.cc.lib
      pkgs.zlib
      pkgs.expat
      pkgs.openssl
      pkgs.fontconfig
      pkgs.libxkbcommon
      pkgs.libx11
      pkgs.libxcb
      pkgs.xcbutilimage
      pkgs.xcbutil
      pkgs.wayland
    ];
    unpackPhase = ''
      dpkg-deb -x $src .
    '';
    installPhase = ''
      mkdir -p $out
      cp -r usr/* $out/
    '';
  };
in {
  home.packages = [
    weztermMatched
  ];
}
