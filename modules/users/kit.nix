{inputs, ...}: {
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
  };

  flake.modules.homeManager."kit" = {
    imports = [
      inputs.starter.modules.homeManager.claude-code
      inputs.starter.modules.homeManager.cli-tools
      inputs.starter.modules.homeManager.cloud-tools
      (inputs.import-tree ../../home/kit)
    ];
  };
}
