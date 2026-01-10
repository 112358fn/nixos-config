{config, pkgs, ...}: {
  services = {
    taskchampion-sync-server = {
      enable = true;
      host = "127.0.0.1";
      port = 10222;
      allowClientIds = ["560c2dd0-7d7c-4e2e-b3a8-b028d6070765"];
    };
    nginx.virtualHosts."tasks.alonsobivou.com" = {
        serverName = "tasks.alonsobivou.com";
        forceSSL = false;
        addSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:10222$request_uri";
          recommendedProxySettings = true;
        };
      };
  };
}
