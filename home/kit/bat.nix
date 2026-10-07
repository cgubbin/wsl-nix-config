{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      style = "numbers,changes,header,grid,snip";
      paging = "never";
    };
    extraPackages = with pkgs.bat-extras; [
      batman
      batgrep
      batdiff
      batwatch
      prettybat
    ];
  };
}
