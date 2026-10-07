{
  config,
  pkgs,
  ...
} @ args: {
  imports = [
    # Safely pull the module from args to avoid the naming clash
    args.inputs.stylix.homeModules.stylix
  ];
  # Configure the global CLI theme engine
  config = {
    stylix = {
      enable = true;

      # Dummy background color generation needed for compilation
      # since this is a headless WSL workspace with no graphics display
      image = config.lib.stylix.pixel "base00";

      # Pull Catppuccin Mocha natively from standard nixpkgs themes
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      polarity = "dark";

      # Automatically theme bottom, git, tmux, and your shells
      autoEnable = true;
    };
  };
}
