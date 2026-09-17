{
  self,
  inputs,
  config,
  ...
}: let
  sops = inputs.starter.lib.mkSopsHost {
    secretsPath = toString inputs.nix-secrets;
    hostFile = "wsl-system.yaml";
    userFile = "wsl-user.yaml";
  };
in {
  flake-file.inputs.nix-secrets = {
    url = "git+ssh://git@github.com/cgubbin/nix-secrets.git";
    flake = false;
  };

  flake.modules.nixos."work" = {
    imports = [
      sops.nixos
      (inputs.starter.lib.mkSopsPasswordUser {username = "kit";})
      self.modules.nixos.kit
    ];
    system.stateVersion = "26.05"; # set once, at first install — never bump this later
    home-manager.users.kit.home.stateVersion = "26.05";
    networking.hostName = "work";

    services.openssh = {
      enable = true;
    };

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (inputs.nixpkgs.lib.getName pkg) [
        "obsidian"
        "terraform"
        "jupytext.nvim"
        "wezterm.nvim"
      ];
    home-manager.useGlobalPkgs = true; # makes home-manager use the system's pkgs, config included

    home-manager.sharedModules = [
      sops.homeManager
      (
        {config, ...}: {
          sops.secrets."netrc".path = "${config.home.homeDirectory}/.netrc";
          sops.secrets."aws-credentials".path = "${config.home.homeDirectory}/.aws/credentials";
        }
      )
    ];

    wsl = {
      wslConf = {
        network.hostname = "work";
      };
    };

    programs.fish.enable = true;
  };

  flake.nixosConfigurations."work" = inputs.starter.lib.mkNixos {
    inherit self inputs;
    hostname = "work";
    platform = "wsl"; # or native
  };
}
