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
    firewall.allowedTCPPorts = [22 80 8096];
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
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
      extraConfig = ''
        StreamLocalBindUnlink yes
      '';
    };
    nextcloud = {
      enable = true;
      home = "/mnt/data/nextcloud";
      package = pkgs.nextcloud27;
      hostName = "cloud.alonsobivou.com";
      https = true;
      database.createLocally = true;
      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        trustedProxies = ["192.168.134.1"];    
        dbtype = "pgsql";
      };
    };
    nginx.virtualHosts.${config.services.nextcloud.hostName} = {
      listenAddresses = ["192.168.134.2"];
    };
    jellyfin.enable = true;
  };
  time.timeZone = "Europe/Stockholm";
}
