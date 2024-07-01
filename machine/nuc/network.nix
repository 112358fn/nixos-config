{ config, ... }: {

  networking = {
    hostName = "nuc";
    firewall.enable = false;
    nftables = {
      enable = true;
      rulesetFile = ./ruleset;
    };
    useNetworkd = true;
  };

  systemd.network = {
    enable = true;
    links = {
      "10-wan" = {
        matchConfig.PermanentMACAddress = "00:1f:c6:9c:46:72";
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
        linkConfig.RequiredForOnline = "yes";
        networkConfig.DHCP = "ipv4";
        networkConfig.IPv6AcceptRA = false;
        networkConfig.KeepConfiguration = "dhcp-on-stop";
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
            Address = "192.168.134.2";
            MACAddress = "b8:27:eb:f9:ee:2f";
          }
          {
            Address = "192.168.134.3";
            MACAddress = "e0:98:06:8d:97:16";
          }
          {
            Address = "192.168.134.4";
            MACAddress = "f4:cf:a2:d4:67:b6";
          }
          {
            Address = "192.168.134.5";
            MACAddress = "f4:cf:a2:d4:7a:37";
          }
        ];
      };
    };
  };
  systemd.services.systemd-networkd.environment.SYSTEMD_LOG_LEVEL = "debug"; 
  systemd.services.systemd-networkd-wait-online.serviceConfig.ExecStart = [
    "" # clear old command
    "${config.systemd.package}/lib/systemd/systemd-networkd-wait-online --interface=wan --timeout=120"
  ];
}
