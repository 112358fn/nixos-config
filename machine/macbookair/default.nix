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
    helix
    wget
    curl
    pulseaudio
    alacritty
    zellij
    firefox
#      texlive.combined.scheme-full
    nixpkgs-fmt
    xss-lock
    i3lock-color
    python311Packages.python-lsp-server
    pinentry-gtk2
  ];
  
  programs.firefox.enable = true;
  
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
    # udev.extraRules = ''
    #   ACTION=="change", SUBSYSTEM=="drm", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/run/user/1000/gdm/Xauthority", RUN+="${pkgs.xorg.xrandr}/bin/xrandr --auto"
    # '';
  };

  time.timeZone = "Europe/Stockholm";
}

