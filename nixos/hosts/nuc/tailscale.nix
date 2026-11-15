{ ... }: {
  services.tailscale = {
    enable = true;
    # Open the WireGuard UDP port so peers can connect directly instead of
    # going through DERP relays.
    openFirewall = true;
  };
}
