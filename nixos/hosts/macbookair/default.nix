{ config, pkgs, ... }:
{
  imports = [
    ./hw.nix
    ./kernel.nix
  ];
  system.stateVersion = "23.05";

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "broadcom-sta-6.30.223.271-59-6.18.42"
      ];
    };
    hostPlatform = "x86_64-linux";
  };

  networking = {
    hostName = "macbookair";
    networkmanager.enable = true;
  };
  systemd.sleep.settings.Sleep.SuspendState = "freeze";

  time.timeZone = "Europe/Stockholm";
}
