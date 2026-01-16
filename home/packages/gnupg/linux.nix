{pkgs, ...}:
{
  imports = [
    ./gpg.nix
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    grabKeyboardAndMouse = true;
    pinentry.package = pkgs.pinentry-gnome3;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}
