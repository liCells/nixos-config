{
  description = "Main NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nix-alien.url = "github:thiagokokada/nix-alien";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland/v0.55.0";

    witr.url = "github:pranshuparmar/witr";

    # aster-web, built from the Forgejo remote so the running binary is a pushed commit.
    # The service reads config/state/workspace beside the checkout at ~/Services/git/aster.
    aster = {
      url = "git+http://10.0.0.10:33000/aster/aster.git";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nix-alien, witr, ... }: {
    nixosConfigurations = {
      tecemine = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          {nixpkgs.overlays = [
            inputs.nix-alien.overlays.default
          ];}
          ./configuration.nix
          home-manager.nixosModules.home-manager
          #witr.packages.${pkgs.system}.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "home-manager.backup";
            home-manager.extraSpecialArgs = { inherit inputs; };

            home-manager.users.tecemine = import ./home;
          }
        ];
      };
    };
  };
}
