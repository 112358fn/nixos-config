HOST=$(shell hostname)
update:
	nix flake lock --update-input nixpkgs
install:
	sudo nixos-rebuild switch --flake .#$(HOST)
