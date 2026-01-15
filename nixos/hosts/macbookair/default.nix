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
        "broadcom-sta-6.30.223.271-59-6.12.63"
      ];
    };
    hostPlatform = "x86_64-linux";
  };

  networking = {
    hostName = "macbookair";
    networkmanager.enable = true;
  };
  systemd.sleep.extraConfig = "SuspendState=freeze";

  time.timeZone = "Europe/Stockholm";
}
