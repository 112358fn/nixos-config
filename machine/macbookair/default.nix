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
    pulseaudio
  ];

  services = {
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
      displayManager.gdm.enable = true;
    };
    pcscd.enable = true;
    dbus.packages = [ pkgs.gcr ];
    logind.extraConfig = ''
      HandlePowerKey=ignore
      HoldoffTimeoutSec=0s
    '';
  };

  time.timeZone = "Europe/Stockholm";
}

