{ config, lib, pkgs, ... }: {

  system.stateVersion = "24.05";
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  
  networking = {
    hostName = "macbookpro";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    helix
    wget
    curl
    alacritty
    zellij
    firefox
    xss-lock
    i3lock-color
    pinentry-gtk2
  ];
  
  programs.firefox.enable = true;
  
  services = {
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
      displayManager.gdm.enable = true;
    };
  };

  time.timeZone = "Europe/Stockholm";
}

