{
  lib,
  ...
}:
{
  imports = [
    ./avahi.nix
    ./firewall.nix
    ./hw.nix
    ./power-profiles.nix
    ./wayland.nix
    ./interception-tools.nix
  ];
  system.stateVersion = "25.11";

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Only root is trusted (the default). Substituters are declared here so
    # untrusted users (home-manager switch, nix develop) still use them; the
    # flake's nixConfig is ignored for untrusted users.
    extra-substituters = [
      "https://noctalia.cachix.org"
      "https://cache.numtide.com" # llm-agents
    ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };
  nix.channel.enable = false;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;

  nixpkgs.hostPlatform = "x86_64-linux";

  networking = {
    hostName = "framework";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Stockholm";

  # Rootless: the daemon runs as the user, so no root-equivalent docker group.
  # Kept on demand like before: `systemctl --user start docker`.
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  systemd.user.services.docker.wantedBy = lib.mkForce [ ];

}
