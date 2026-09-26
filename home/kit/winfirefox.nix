{
  pkgs,
  lib,
  ...
}: let
  firefoxPath = "/mnt/c/Program Files/Mozilla Firefox/firefox.exe";

  winfirefox = pkgs.writeShellScriptBin "winfirefox" ''
    exec "${firefoxPath}" "$@"
  '';

  # Overrides xdg-open so tools that call it also open Windows Firefox
  xdg-open-win = pkgs.writeShellScriptBin "xdg-open" ''
    exec "${firefoxPath}" "$@"
  '';
in {
  home.packages = [
    winfirefox
    (lib.hiPrio xdg-open-win) # hiPrio wins if xdg-utils is also installed
  ];

  programs.fish.shellInit = ''
    set -gx BROWSER ${winfirefox}/bin/winfirefox
  '';
}
