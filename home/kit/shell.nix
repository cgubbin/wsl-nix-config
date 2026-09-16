{pkgs, ...}: {
  users.users.kit.shell = pkgs.fish; # NixOS-level option, not home-manager
}
