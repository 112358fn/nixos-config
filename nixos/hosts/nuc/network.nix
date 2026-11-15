{ config, ... }: {

  networking = {
    hostName = "nuc";
    # Services are only reachable from the LAN ("wan" is the NIC facing the
    # home router) and the tailnet. Everything else (Jellyfin :8096,
    # Mattermost :8065, ...) is only reachable through nginx on localhost.
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      interfaces = {
        wan.allowedTCPPorts = [ 22 80 443 ];
        tailscale0.allowedTCPPorts = [ 22 80 443 ];
      };
    };
    useNetworkd = true;
    nameservers = [ "1.1.1.1" "9.9.9.9" ];
  };

  systemd.network = {
    enable = true;
    links = {
      "10-wan" = {
        matchConfig.PermanentMACAddress = "00:1f:c6:9c:46:72";
        linkConfig.Name = "wan";
      };
    };
    networks = {
      "10-wan" = {
        matchConfig.Name = "wan";
        networkConfig.DHCP = "ipv4";
      };
    };
  };
}
