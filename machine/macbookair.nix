{ config, pkgs, ... }:

{
  system.stateVersion = "23.05"; 
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "macbookair";
    networkmanager.enable = true;
  };
 
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
  ];

  services = {
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
      displayManager.gdm.enable = true;
    };
    pcscd.enable = true;
    dbus.packages = [ pkgs.gcr ];
  };

  programs = {
    zsh.enable = true; 
    ssh.startAgent = true;
  };

  time.timeZone = "Europe/Stockholm";
  
  sound.enable = true;
  hardware.pulseaudio.enable = true;
}

