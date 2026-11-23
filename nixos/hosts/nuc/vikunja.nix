{ ... }: let
  hostname = "todo.alonsobivou.com";
in {
  services = {
    vikunja = {
      enable = true;
      address = "127.0.0.1";
      port = 3456;
      frontendScheme = "https";
      frontendHostname = hostname;
      # Public through the Cloudflare tunnel, so no open sign-up.
      # Create users with: vikunja user create -u <name> -e <email>
      settings.service.enableregistration = false;
    };
    nginx.virtualHosts.${hostname} = {
      serverName = hostname;
      forceSSL = true;
      useACMEHost = "alonsobivou.com";
      locations."/" = {
        proxyPass = "http://127.0.0.1:3456$request_uri";
        recommendedProxySettings = true;
        proxyWebsockets = true;
        # Matches Vikunja's default files.maxsize (attachments).
        extraConfig = ''
          client_max_body_size 20M;
        '';
      };
    };
    # Public route: Cloudflare edge -> tunnel -> nginx -> vikunja.
    # The DNS record has to be created once with:
    # cloudflared tunnel route dns nuc todo.alonsobivou.com
    cloudflared.tunnels.nuc.ingress.${hostname} = {
      service = "https://127.0.0.1:443";
      # nginx picks the vhost by SNI and serves the wildcard cert for it.
      originRequest.originServerName = hostname;
    };
  };
}
