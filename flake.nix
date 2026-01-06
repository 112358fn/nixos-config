{
  description = "Alvaro's NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs:
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
    };
}
