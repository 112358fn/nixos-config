{ config, pkgs, ... }: {
  imports = [
    ./network.nix
    ./godns.nix
    ./bind
    ./nginx.nix
    ./tailscale.nix
    ];
  system.stateVersion = "23.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    git
    helix
    wget
    curl
    jellyfin-ffmpeg
  ];
  
  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
      extraConfig = ''
        StreamLocalBindUnlink yes
      '';
    };
    nextcloud = {
      enable = true;
      home = "/mnt/data/nextcloud";
      package = pkgs.nextcloud28;
      hostName = "cloud.alonsobivou.com";
      https = true;
      database.createLocally = true;
      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        dbtype = "pgsql";
      };
    };
    jellyfin.enable = true;
  };
  time.timeZone = "Europe/Stockholm";
}
