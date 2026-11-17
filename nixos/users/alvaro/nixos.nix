{ pkgs, lib, ... }:
{
  imports = [
    ./base.nix
  ];

  users.users.alvaro.extraGroups = [
    "dialout"
    "i2c"
  ];

  programs.dconf.enable = true;
  # Needed to use uv
  # https://nix.dev/guides/faq#how-to-run-non-nix-executables
  programs.nix-ld.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    noto-fonts-color-emoji
    lato
    adwaita-fonts
  ];
  security = {
    polkit.enable = true;
    pam.services.swaylock = { };
  };
  services = {
    pcscd.enable = true;
    dbus.packages = [ pkgs.gcr ];

    # Evolution data server is used
    # by calendar and notes
    gnome.evolution-data-server.enable = true;
    gnome.gnome-keyring.enable = true;
    gnome.gnome-online-accounts.enable = true;

    # D-BUS service to manipulate storage devs
    udisks2.enable = true;
    # Tailscale
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
    # Upower
    upower.enable = true;
    # uaccess for YubiKey hidraw (OTP/management via ykman) only, instead of
    # every HID device; FIDO tokens are already tagged by systemd's fido_id.
    udev.packages = [ pkgs.yubikey-personalization ];
  };
}
