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
        router = mknixos "thinkpad" {
          inherit nixpkgs;
          system = "x86_64-linux";
          user = "admin";
        };
        server = mknixos "nuc" {
          inherit nixpkgs;
          system = "x86_64-linux";
          user = "alvaro";
        };
      };
    };
}
