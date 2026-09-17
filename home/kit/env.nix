{config, ...}: {
  programs.fish.shellInit = ''
    if test -f ${config.sops.templates."do-spaces-env".path}
      source ${config.sops.templates."do-spaces-env".path}
    end
  '';
}
