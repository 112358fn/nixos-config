{  ... }: {
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;

    # Catch-all: drop requests for unknown hosts (e.g. by bare IP) instead of
    # serving whichever vhost happens to be first.
    virtualHosts."_" = {
      default = true;
      rejectSSL = true;
      locations."/".return = "444";
    };
  };

  # nginx reads the wildcard cert from the acme group.
  users.users.nginx.extraGroups = [ "acme" ];

  security.acme = {
    acceptTerms = true;
    defaults.email = "112358.fn@gmail.com";

    # One wildcard cert for every *.alonsobivou.com service, issued with the
    # DNS-01 challenge so nothing has to be reachable from the internet.
    # vhosts use it with `useACMEHost = "alonsobivou.com"`.
    certs."alonsobivou.com" = {
      domain = "*.alonsobivou.com";
      dnsProvider = "cloudflare";
      # Check propagation against a public resolver, not the home router
      # (which overrides these names with LAN IPs).
      dnsResolver = "1.1.1.1:53";
      # Must contain: CF_DNS_API_TOKEN=<token>
      # Token scope: Zone -> DNS -> Edit, limited to the alonsobivou.com zone.
      # File should be root:root 0400.
      environmentFile = "/var/lib/secrets/acme-cloudflare.env";
      group = "acme";
    };
  };
}
