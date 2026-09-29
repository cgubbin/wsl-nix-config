{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.workbench.packages.${pkgs.stdenv.hostPlatform.system}.wb
  ];
}
