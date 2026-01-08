{ config, ... }: {

  networking = {
    hostName = "nuc";
    firewall.enable = false;
    # nftables = {
    #   enable = true;
    #   rulesetFile = ./ruleset;
    # };
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
