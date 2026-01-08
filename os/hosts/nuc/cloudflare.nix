{...}: {
  services.cloudflared = {
    enable = true;
    tunnels.nuc = {
      # Credentials created using
      # nix shell nixpkgs#cloudflared
      # cloudflared login
      # cloudflared tunnel token --credentials-file nuc.json nuc
      # More in
      # https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/do-more-with-tunnels/local-management/tunnel-permissions/
      credentialsFile = "/home/alvaro/.cloudflared/nuc.json";
      default = "http_status:404";
    };
  };
}
