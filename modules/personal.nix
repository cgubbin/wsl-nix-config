{...}: {
  flake-file.inputs.starter = {
    url = "git+ssh://git@github.com/wave-photonics/nix-wsl-template.git";
    # starter pins its own nixpkgs; follow ours so the system tracks our lock
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
