{
  lib,
  nixpkgs,
  username,
  ...
}: {
  # Make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
  nix.registry.nixpkgs.flake = nixpkgs;

  nix.settings = {
    auto-optimise-store = false;
    experimental-features = ["nix-command" "flakes"];
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    allowUnsupportedSystem = false;
  };

  # Garbage collect weekly
  nix.gc = {
    user = username;
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
}
