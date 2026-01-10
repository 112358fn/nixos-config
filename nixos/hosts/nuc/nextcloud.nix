{ pkgs, ... }: {
  services = {
    nextcloud = {
      enable = true;
      home = "/mnt/data/nextcloud";
      package = pkgs.nextcloud31;
      hostName = "cloud.alonsobivou.com";
      https = true;
      database.createLocally = true;
      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        dbtype = "pgsql";
      };
    };
    nginx.virtualHosts."cloud.alonsobivou.com" = {
      serverName = "cloud.alonsobivou.com";
      forceSSL = false; 
      addSSL = true;
      enableACME = true;
    };
  };
}
