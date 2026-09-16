{pkgs, ...}: let
in {
  home.packages = (
    with pkgs; [
      trash-cli
      dust
      duf
      dysk
      ripgrep
      htop
      procs

      yq-go
      jq
      just
      eza
      fd
      tree
      watch

      watchexec
      hurl

      nix-output-monitor
      nix-direnv
      noti
      killall
      wget
      tdf
      see-cat
      rsync

      hexyl
      nasm
      broot

      # Yazi functionality
      ffmpeg-headless
      p7zip
      poppler
      resvg
      imagemagick

      aerc
      ast-grep
      hunspell
      semgrep
      shellcheck
      treefmt
      zathura

      xclip
      grim
      slurp
      valgrind
      bandwhich
      proximity-sort

      nix-tree
      tokei
      gh
      hub

      typst
      tinymist

      clang
      gnumake
      tree-sitter
    ]
  );
}
