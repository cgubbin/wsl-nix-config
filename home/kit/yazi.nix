{...}: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    enableFishIntegration = true;
  };
}
