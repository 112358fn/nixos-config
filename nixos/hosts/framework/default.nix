{ config, pkgs, ... }:
{
  imports = [
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

  services.getty = {
    autologinUser = "alvaro";
    autologinOnce = true;
  };

  time.timeZone = "Europe/Stockholm";

}
