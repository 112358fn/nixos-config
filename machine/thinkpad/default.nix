{ pkgs, ... }: {
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
    nixpkgs-fmt
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
    pcscd.enable = true;
    dbus.packages = [ pkgs.gcr ];
    logind.extraConfig = ''
      HandlePowerKey=ignore
      HoldoffTimeoutSec=0s
    '';
  };
  time.timeZone = "Europe/Stockholm";

}
