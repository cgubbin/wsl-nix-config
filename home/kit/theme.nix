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

      targets = {
        # Disable desktop environments that require D-Bus activation hooks
        gnome.enable = false;
        kde.enable = false;
        xfce.enable = false;
        eog.enable = false;
        gnome-text-editor.enable = false;
        rofi.enable = false;

        # Disable global GTK/Qt themes (these break on headless WSL)
        gtk.enable = false;
        qt.enable = false;

        # Optional: Disable notification frameworks if you use them
        dunst.enable = false;
        mako.enable = false;
      };
    };
  };
}
