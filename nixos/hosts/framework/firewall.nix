# firewalld with NetworkManager picking the zone per connection: every
# network lands in the restrictive default zone (nixos-fw-default, built from
# networking.firewall.*) unless its NM profile is bound to nixos-home:
#
#   nmcli connection modify <name> connection.zone nixos-home
#
# The binding lives in the (imperative) NM profile, not here.
{ config, lib, ... }:
let
  default = config.services.firewalld.zones.nixos-fw-default;
  tcp = port: {
    protocol = "tcp";
    inherit port;
  };
  udp = port: {
    protocol = "udp";
    inherit port;
  };
  kdeconnect = {
    from = 1714;
    to = 1764;
  };
in
{
  networking.nftables.enable = true;

  services.firewalld = {
    enable = true;
    zones.nixos-home = {
      short = "Home";
      description = "Trusted LAN: default-zone baseline plus local services";
      inherit (default) target icmpBlockInversion icmpBlocks;
      ports = default.ports ++ [
        # KDE Connect
        (tcp kdeconnect)
        (udp kdeconnect)
        # Syncthing: sync protocol + local discovery
        (tcp 22000)
        (udp 22000)
        (udp 21027)
        # Calibre wireless device connection (KOReader)
        (tcp 9099)
        (tcp 8080)
      ];
    };
  };
}
