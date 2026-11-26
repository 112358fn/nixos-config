{inputs, ...}:
{
  imports = [inputs.kosync.nixosModules.x86_64-linux.default];
  services.kosync = {
    enable = true;
    port = 7200;
    host = "127.0.0.1";
  };
  services.nginx.virtualHosts."reading.alonsobivou.com" = {
    serverName = "reading.alonsobivou.com";
    forceSSL = true;
    useACMEHost = "alonsobivou.com";
    locations."/" = {
      proxyPass = "http://127.0.0.1:7200$request_uri";
      recommendedProxySettings = true;
    };
  };
}
