HOST=$(shell hostname)
update:
	nix flake update
install:
	sudo nixos-rebuild switch --flake .#$(HOST)
