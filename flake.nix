{
  description = "Main NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, hyprpanel, ... }: {
    nixosConfigurations = {
      tecemine = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          {nixpkgs.overlays = [inputs.hyprpanel.overlay];}
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "home-manager.backup";

            home-manager.users.tecemine = import ./config/main.nix;
          }
        ];
      };
    };
  };
}
