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
      nixosConfigurations = {
        macbookair = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hardware/macbookair.nix
            ./machine/macbookair
            ./user/alvaro/nixos.nix
            ];
        };
        thinkpad = mknixos "thinkpad" {
          inherit nixpkgs;
          system = "x86_64-linux";
          user = "alvaro";
        };
        nuc = mknixos "nuc" {
          inherit nixpkgs;
          system = "x86_64-linux";
          user = "alvaro";
        };
        hppavilion = mknixos "hppavilion" {
          inherit nixpkgs;
          system = "x86_64-linux";
          user = "alvaro";
        };
        macbookpro = mknixos "macbookpro" {
          inherit nixpkgs;
          system = "x86_64-linux";
          user = "alvaro";
        };
      };
      homeConfigurations = {
        "alvaro@macbookair" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/macbookair.nix];
        };
      };
    };
}
