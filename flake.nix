{
  description = "Nix flakes configuration for darwin and NixOS";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    darwin,
    nixpkgs,
    home-manager,
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
