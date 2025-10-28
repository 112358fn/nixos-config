{...}: {
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    extraConfig = ''
      StreamLocalBindUnlink yes
    '';
  };
}
