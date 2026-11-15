{...}: {
  services.openssh = {
    enable = true;
    # Reachability is limited by the firewall (see network.nix).
    openFirewall = false;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
    extraConfig = ''
      StreamLocalBindUnlink yes
    '';
  };
}
