{
  description = "Alvaro's NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      mknixos = import ./lib/mknixos.nix;
    in
    {
      nixosConfigurations = {
        macbookair = mknixos "macbookair" {
          inherit nixpkgs;
          system = "x86_64-linux";
          user = "alvaro";
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
      };
    };
}
