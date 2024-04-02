{pkgs, ...}: {
  nix.settings = {
    auto-optimise-store = false;
    experimental-features = ["nix-command" "flakes"];
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    permittedInsecurePackages = ["electron-25.9.0"];
  };

  # Perform garbage collection weekly
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
}
