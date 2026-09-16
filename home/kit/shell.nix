{pkgs, ...}: {
  programs.bash.initExtra = ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" ]]; then
      exec ${pkgs.fish}/bin/fish
    fi
  '';
}
