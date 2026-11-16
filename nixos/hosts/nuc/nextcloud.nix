{ pkgs, ... }: {
  services = {
    postgresql.settings = {
      shared_buffers = "2GB";        # fit the DB with headroom; ≤ 25% of RAM
      effective_cache_size = "16GB"; # planner hint only, allocates nothing
    };
    nextcloud = {
      enable = true;
      home = "/mnt/data/nextcloud";
      package = pkgs.nextcloud35;
      hostName = "cloud.alonsobivou.com";
      https = true;
      database.createLocally = true;
      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        dbtype = "pgsql";
      };
      settings = {
        maintenance_window_start = 1;
        default_phone_region = "SE";
        mail_smtpmode = "smtp";
        mail_smtphost = "mail-eu.smtp2go.com";
        mail_smtpport = 8465;
        mail_smtpsecure = "ssl";
        mail_smtpauth = true;
        mail_smtpname = "noreply.cloud.alonsobivou.com";
        mail_from_address = "noreply";
        mail_domain = "cloud.alonsobivou.com";
      };
      secretFile = "/var/lib/secrets/nextcloud.json";
      phpOptions."opcache.interned_strings_buffer" = "16";
    };
    nginx.virtualHosts."cloud.alonsobivou.com" = {
      serverName = "cloud.alonsobivou.com";
      forceSSL = true;
      useACMEHost = "alonsobivou.com";
    };
  };
}
