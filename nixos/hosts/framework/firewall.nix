{ lib, ... }:
let
  lan = rec {
    # KDE Connect
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;

    # Syncthing
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [
      22000
      21027
    ];
  };
in
{
  networking.firewall.interfaces = lib.genAttrs [ "wl+" "en+" ] (_: lan);
}
