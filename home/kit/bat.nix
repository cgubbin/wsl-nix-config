{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      style = "numbers,changes,header,grid,snip";
      paging = "never";
      theme = "cattpucinMocha";
    };
    extraPackages = with pkgs.bat-extras; [
      batman
      batgrep
      batdiff
      batwatch
      prettybat
    ];
    themes = {
      cattpucinMocha = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
          sha256 = "lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
  };
}
