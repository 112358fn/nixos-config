{
  description = "Alvaro's nix systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:
    let
      mknixos = import ./lib/mknixos.nix;
    in
    {
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        macbookair = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nixos/hosts/macbookair
            ./nixos/users/alvaro/nixos.nix
            ];
        };
        thinkpad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nixos/hosts/thinkpad
            ./nixos/users/alvaro
            ];
        };
        nuc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nixos/hosts/nuc
            ./nixos/users/alvaro
            ];
        };
      };
      homeConfigurations = {
        "alvaro@macbookair" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/macbookair.nix];
        };
        "AALONSO" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/macbookpro.nix];
        };
      };
    };
}
