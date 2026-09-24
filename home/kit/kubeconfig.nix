{config, ...}: {
  programs.fish.interactiveShellInit = ''
    mkdir -p ${config.home.homeDirectory}/.kube
    set -gx KUBECONFIG ${config.home.homeDirectory}/.kube/config-local:${config.sops.templates."kubeconfig-base".path}
  '';
}
