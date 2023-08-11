{
  description = "Alvaro's NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      mknixos = import ./lib/mknixos.nix;
    in
    {
      nixosConfigurations = {
        macbookair = mknixos "macbookair" {
          inherit nixpkgs home-manager;
          system = "x86_64-linux";
          user = "alvaro";
        };
        router = mknixos "thinkpad" {
          inherit nixpkgs home-manager;
          system = "x86_64-linux";
          user = "admin";
        };
      };
    };
}
