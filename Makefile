HOST=$(shell hostname)
update:
	nix flake update
install:
	sudo nixos-rebuild switch --flake .#$(HOST)
diff:
	@TMPDIR="result"; \
	trap 'rm "$$TMPDIR"' EXIT; \
	nixos-rebuild build --flake ".#$(HOST)" && \
	nvd diff /run/current-system result;
