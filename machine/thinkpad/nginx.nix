{ ... }: {
  services.nginx = {
    enable = true;
    virtualHosts.nextcloud = {
      serverName = "cloud.alonsobivou.com";
      forceSSL = true; 
      enableACME = true;
      locations."/" = {
        proxyPass = "http://192.168.1.200:11000$request_uri";
        recommendedProxySettings = true;
      };
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "112358.fn@gmail.com";
  };
}
