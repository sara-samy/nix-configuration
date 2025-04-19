{
  description = "Nix flakes configuration for darwin and NixOS";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };

    darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin-custom-icons = {
      url = "github:ryanccn/nix-darwin-custom-icons";
    };
  };

  outputs = inputs @ {
    self,
    darwin,
    nixpkgs,
    home-manager,
    darwin-custom-icons,
    ...
  }: let
    username = "sarasamy";
    hostnameNixOS = "nixos";
    hostnameDarwin = "darwin";
    specialArgs =
      inputs
      // {
        inherit username hostnameNixOS hostnameDarwin;
      };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#hostname
    darwinConfigurations."${hostnameDarwin}" = darwin.lib.darwinSystem {
      inherit specialArgs;
      system = "aarch64-darwin";
      modules = [
        ./hosts/${hostnameDarwin}/core.nix
        ./hosts/${hostnameDarwin}/users.nix
        ./hosts/${hostnameDarwin}/programs.nix
        darwin-custom-icons.darwinModules.default

        home-manager.darwinModules.home-manager
        {
          users.users.${username}.home = "/Users/${username}";

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users.${username} = import ./home-manager/darwin-home/home.nix;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."darwin".pkgs;

    # Build nixOS flake using:
    # $ sudo nixos-rebuild switch --flake .#hostname
    nixosConfigurations.${hostnameNixOS} = nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      system = "x86_64-linux";
      modules = [
        ./hosts/${hostnameNixOS}/core.nix
        ./hosts/${hostnameNixOS}/users.nix
        ./hosts/${hostnameNixOS}/programs.nix
        ./hosts/${hostnameNixOS}/services.nix

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users.${username} = import ./home-manager/nixos-home/home.nix;
          };
        }
      ];
    };
  };
}
