{ ... }: {
  # TODO: still public via the Cloudflare tunnel (see cloudflare.nix), and its
  # cert still uses HTTP-01 through that tunnel. Decide whether Mattermost
  # stays public before removing the tunnel.
  services = {
    mattermost = {
      enable = true;
      mutableConfig = true;
      preferNixConfig = false;
      siteUrl = "https://chat.opstackle.ai";
      database.peerAuth = true;
      database.socketPath = "/run/postgresql";
      database.host = "127.0.0.1";
    };
    nginx.virtualHosts."chat.opstackle.ai" = {
      serverName = "chat.opstackle.ai";
      serverAliases = ["chat.opstackle.dev" "chat.opstackle.xyz"];
      forceSSL = false;
      addSSL = true;
      enableACME = true;
      locations."~ /api/v[0-9]+/(users/)?websocket$" = {
        proxyPass = "http://127.0.0.1:8065$request_uri";
        proxyWebsockets = true;
        recommendedProxySettings = true;
      };
      locations."/" = {
        proxyPass = "http://127.0.0.1:8065$request_uri";
        recommendedProxySettings = true;
        extraConfig = ''
          client_max_body_size 100M;
        '';
      };
    };
  };
}
