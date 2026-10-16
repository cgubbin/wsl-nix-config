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
      jd-diff-patch
      jiq
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
      # TODO: drop once fixed upstream; vendored tree-sitter-perl's bsearch
      # clashes with glibc 2.44's C23 _Generic macro
      (see-cat.overrideAttrs (old: {
        env = (old.env or {}) // {CFLAGS = "-std=gnu17";};
      }))
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
      # TODO: drop once nixpkgs relaxes semgrep's pyjwt~=2.13 pin
      (semgrep.overridePythonAttrs (old: {
        pythonRelaxDeps = (old.pythonRelaxDeps or []) ++ ["pyjwt"];
      }))
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
