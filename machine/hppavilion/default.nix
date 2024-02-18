{ config, lib, pkgs, ... }: {

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda"; 

  networking = {
    hostName = "hppavilion";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    helix
    wget
    curl
    pulseaudio
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
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
      extraConfig = ''
        StreamLocalBindUnlink yes
      '';
    };
  };

  time.timeZone = "Europe/Stockholm";

  system.stateVersion = "23.11";
}
