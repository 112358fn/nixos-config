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
  ];
  system.stateVersion = "25.11";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.channel.enable = false;

  nixpkgs.hostPlatform = "x86_64-linux";

  networking = {
    hostName = "framework";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Stockholm";

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
  # To remove docker0 nic
  # sudo systemctl stop docker && sudo ip link delete docker0
  systemd.sockets.docker.wantedBy = lib.mkForce [ ];

  # YubiKey as an alternative to the password in PAM (sudo, swaylock, ...).
  # "sufficient" means the password always works as fallback, so a missing
  # or unenrolled key can never lock us out.
  security.pam.u2f = {
    enable = true;
    control = "sufficient";
    settings.cue = true;
  };

}
