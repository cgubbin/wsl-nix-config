# home/kit/kuiui.nix
{
  config,
  lib,
  pkgs,
  ...
}: let
  binDir = "${config.home.homeDirectory}/.local/bin";
in {
  home.packages = [pkgs.gh]; # needed to run gh release download

  home.activation.installKuiui = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "${binDir}"
    if [ ! -x "${binDir}/kuiui" ]; then
      $DRY_RUN_CMD ${pkgs.gh}/bin/gh release download --repo wave-photonics/kuiui --pattern "kuiui" --dir "${binDir}" --clobber
      $DRY_RUN_CMD chmod +x "${binDir}/kuiui"
    fi
  '';
}
