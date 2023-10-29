{ config, ... }: {

  networking = {
    hostName = "thinkpad";
    firewall.enable = false;
    nftables = {
      enable = true;
      rulesetFile = ./ruleset;
    };
  };

  systemd.network = {
    enable = true;
    links = {
      "10-wan" = {
        matchConfig.PermanentMACAddress = "3c:97:0e:25:fe:2a";
        linkConfig.Name = "wan";
      };
      "10-lan" = {
        matchConfig.PermanentMACAddress = "9c:eb:e8:f9:19:c1";
        linkConfig.Name = "lan";
      };
    };
    networks = {
      "10-wan" = {
        matchConfig.Name = "wan";
        linkConfig.RequiredForOnline = "no";
        networkConfig.DHCP = "ipv4";
      };
      "10-lan" = {
        matchConfig.Name = "lan";
        linkConfig.RequiredForOnline = "no";
        networkConfig = {
          Address = "192.168.134.1/24";
          DHCPServer = "yes";
          IPForward = "ipv4";
          ConfigureWithoutCarrier = true;
        };
        dhcpServerConfig = {
          ServerAddress = "192.168.134.1/24";
          EmitDNS = true;
          DNS = "_server_address";
        };
        dhcpServerStaticLeases = [
          {
            dhcpServerStaticLeaseConfig = {
              Address = "192.168.134.2";
              MACAddress = "00:c2:c6:f1:8c:c2";
            };
          }
        ];
      };
    };
  };
  systemd.services.systemd-networkd-wait-online.serviceConfig.ExecStart = [
    "" # clear old command
    "${config.systemd.package}/lib/systemd/systemd-networkd-wait-online --interface=wan --timeout=120"
  ];
}
