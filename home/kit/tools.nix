# Work-specific packages on top of personal-features' shared-cli-core.
{pkgs, ...}: {
  home.packages = with pkgs; [
    jd-diff-patch
    jiq
    tdf
    # TODO: drop once fixed upstream; vendored tree-sitter-perl's bsearch
    # clashes with glibc 2.44's C23 _Generic macro
    (see-cat.overrideAttrs (old: {
      env = (old.env or {}) // {CFLAGS = "-std=gnu17";};
    }))
    nasm

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
  ];
}
