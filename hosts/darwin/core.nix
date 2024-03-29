{
  pkgs,
  lib,
  ...
}: {
  nix.package = pkgs.nix;

  nix.settings = {
    auto-optimise-store = false;
    experimental-features = ["nix-command" "flakes"];
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  # Garbage collect weekly
  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
}
