{ config, ... }: {
  services.nginx = {
    enable = true;

    virtualHosts.${config.services.nextcloud.hostName} = {
      # listenAddresses = ["192.168.134.2"];
      serverName = "cloud.alonsobivou.com";
      forceSSL = true; 
      enableACME = true;
      # locations."/" = {
      #   proxyPass = "http://192.168.134.214:11000$request_uri";
      #   recommendedProxySettings = true;
      # };
    };
    virtualHosts."media.alonsobivou.com" = {
      serverName = "media.alonsobivou.com";
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8096$request_uri";
        recommendedProxySettings = true;
      };
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "112358.fn@gmail.com";
  };
}
