{inputs, ...}:
{
  imports = [inputs.crosspoint-sync.nixosModules.crosspoint-sync];
  services.crosspoint-sync = {
    enable = true;
    port = 8080;
    registration = true;
  };
  services.nginx.virtualHosts."reading.alonsobivou.com" = {
    serverName = "reading.alonsobivou.com";
    forceSSL = true;
    useACMEHost = "alonsobivou.com";
    locations."/" = {
      proxyPass = "http://[::1]:8080$request_uri";
      recommendedProxySettings = true;
    };
  };
}
