{inputs, ...}: {
  flake-file.inputs.nixvim = {
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos."kit" = {
    home-manager.users."kit" = {
      imports = [inputs.self.modules.homeManager."kit"];
    };

    users.users."kit" = {pkgs, ...}: {
      isNormalUser = true;
      group = "kit";
      extraGroups = ["wheel"];
      shell = pkgs.fish;
    };
    users.groups."kit" = {};

    wsl = {
      defaultUser = "kit";
    };
  };

  flake.modules.homeManager."kit" = {
    imports = [
      inputs.starter.modules.homeManager.claude-code
      inputs.starter.modules.homeManager.cli-tools
      inputs.starter.modules.homeManager.cloud-tools
      inputs.starter.modules.homeManager.direnv
      inputs.starter.modules.homeManager.git
      (inputs.import-tree ../../home/kit)
    ];
  };
}
