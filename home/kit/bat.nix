# bat itself comes from shared-cli-core; keep the work style and bat-extras.
{
  lib,
  pkgs,
  ...
}: {
  programs.bat = {
    config.style = lib.mkForce "numbers,changes,header,grid,snip";
    extraPackages = with pkgs.bat-extras; [
      batman
      batgrep
      batdiff
      batwatch
      prettybat
    ];
  };
}
