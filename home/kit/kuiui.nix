{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.kuiui.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
