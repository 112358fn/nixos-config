{ ... }:
{
  services.cloudflared = {
    enable = true;
    tunnels.framework = {
      # Credentials created using
      # nix shell nixpkgs#cloudflared
      # cloudflared login
      # cloudflared tunnel token --credentials-file nuc.json nuc
      # More in
      # https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/do-more-with-tunnels/local-management/tunnel-permissions/
      credentialsFile = "/home/alvaro/.cloudflared/framework.json";
      default = "http_status:404";
    };
  };
  services.nginx = {
    enable = true;

  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "112358.fn@gmail.com";
  };
  services = {
    ollama = {
      enable = true;
      acceleration = "rocm";
    };
    nginx.virtualHosts."ollama.alonsobivou.com" = {
      serverName = "ollama.alonsobivou.com";
      forceSSL = false;
      addSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:11434$request_uri";
        extraConfig = ''
          proxy_set_header Host localhost:11434;
        '';
      };
    };
  };

}
