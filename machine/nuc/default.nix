{ config, pkgs, ... }:

{
  system.stateVersion = "23.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nuc";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    helix
    wget
    curl
  ];
  
  services = {
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
      displayManager.gdm.enable = true;
    };
  };
  time.timeZone = "Europe/Stockholm";
}
