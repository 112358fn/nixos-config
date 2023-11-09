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
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "112358.fn@gmail.com";
  };
}
