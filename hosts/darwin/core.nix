{
  lib,
  nixpkgs,
  username,
  ...
}: {
  nix.enable = false;

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    allowUnsupportedSystem = false;
  };
}
