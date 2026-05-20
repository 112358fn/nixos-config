{ config, pkgs, ... }:
{
  imports = [
    ./firewall.nix
    ./hw.nix
  ];
  system.stateVersion = "25.11";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking = {
    hostName = "framework";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Stockholm";

}
