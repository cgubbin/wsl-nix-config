{inputs, ...}: {
  flake-file.inputs = {
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quarto-sync-nvim = {
      url = "git+ssh://git@github.com/cgubbin/quarto-sync.git";
      flake = false; # it's a plain vim plugin, not a flake itself
    };
    workbench = {
      url = "git+ssh://git@github.com/cgubbin/workbench.git";
    };
    personal-features = {
      url = "github:cgubbin/nix-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kuiui = {
      url = "git+ssh://git@github.com/wave-photonics/kuiui.git?ref=meep_optimiser_2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
    };
  };

  flake.modules.nixos."kit" = {
    home-manager.users."kit" = {
      imports = [inputs.self.modules.homeManager."kit"];
    };

    users.users."kit" = {
      isNormalUser = true;
      group = "kit";
      extraGroups = ["wheel"];
    };

    users.groups."kit" = {};

    wsl = {
      defaultUser = "kit";
    };
  };

  flake.modules.homeManager."kit" = {
    lib,
    pkgs,
    ...
  }: {
    imports = [
      inputs.personal-features.modules.homeManager.shared-doom-emacs
      inputs.personal-features.modules.homeManager.shared-zellij
      inputs.personal-features.modules.homeManager.shared-editor
      inputs.nixvim.homeModules.nixvim
      inputs.starter.modules.homeManager.cli-tools
      inputs.starter.modules.homeManager.cloud-tools
      inputs.starter.modules.homeManager.direnv
      inputs.starter.modules.homeManager.git
      inputs.starter.modules.homeManager.llm-tools
      (inputs.import-tree ../../home/kit)
    ];

    knowledge.orgDirectory = "/home/kit/notes/work";
    knowledge.enableDaemon = true;
    knowledge.enableGraphicalIntegration = false;

    # Home Manager defaults to leaving the daemon running across switches so
    # unsaved buffers survive; restart it instead so config changes apply.
    # Save buffers before switching.
    systemd.user.services.emacs.Unit.X-RestartIfChanged = lib.mkForce true;
    # WezTerm's COLORTERM does not cross into WSL; advertise truecolor to
    # shells, zellij panes and nvim as well.
    home.sessionVariables.COLORTERM = "truecolor";

    sharedEditor = {
      configDirectory = "/home/kit/system/config";
      clipboardProvider = "xsel";
      imageBackend = "kitty";
      quartoSyncPackage = pkgs.vimUtils.buildVimPlugin {
        name = "quarto-sync-nvim";
        src = inputs.quarto-sync-nvim;
      };
    };
  };
}
