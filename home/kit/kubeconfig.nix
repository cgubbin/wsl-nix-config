{config, ...}: {
  programs.fish.interactiveShellInit = ''
    set -gx KUBECONFIG ${config.home.homeDirectory}/.kube/config:${config.sops.templates."kubeconfig-oidc-user".path}
  '';
}
