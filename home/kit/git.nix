# Work identity and ignores; aliases, pull/rebase defaults and delta come from
# personal-features' shared-git.
{...}: {
  programs.git = {
    settings = {
      user = {
        name = "kit";
        email = "christopher.gubbin@wavephotonics.com";
      };
      github.user = "kit";
    };

    ignores = [
      ".envrc"
      ".direnv/"
      ".jupyter-local/"
      ".quarto/"
      ".wbpy"
    ];
  };
}
