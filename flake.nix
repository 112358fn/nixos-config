{
  description = "Alvaro's nix systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    direnv-instant.url = "github:Mic92/direnv-instant";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      home-manager,
      llm-agents,
      ...
    }@inputs:
    {
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        framework = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-hardware.nixosModules.framework-13-7040-amd
            ./nixos/hosts/framework
            ./nixos/users/alvaro/nixos.nix
          ];
        };
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
            ./nixos/users/alvaro/nixos.nix
          ];
        };
        nuc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nixos/hosts/nuc
            ./nixos/users/alvaro/base.nix
          ];
        };
      };
      homeConfigurations = {
        "alvaro@framework" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            { home.username = "alvaro"; }
            ./home/alvaro/at_framework.nix
          ];
        };
      };
    };
}
