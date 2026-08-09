{pkgs, ...}: {
  services = {
    # Actual: Finance tool
    actual = {
      enable = true;
      package = pkgs.unstable.actual-server;
      settings.hostname = "127.0.0.1";
      settings.port = 3000;
    };
    nginx.virtualHosts."budget.alonsobivou.com" = {
      serverName = "budget.alonsobivou.com";
      forceSSL = false;
      addSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000$request_uri";
        recommendedProxySettings = true;
      };
    };
  };
}
