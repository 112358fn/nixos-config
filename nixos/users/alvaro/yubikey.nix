{ pkgs, ... }: {
  # gpg-agent (home-manager) is the SSH agent, with the YubiKey key; don't let
  # gnome-keyring's gcr agent compete for SSH_AUTH_SOCK.
  services = {
    gnome.gcr-ssh-agent.enable = false;
    pcscd.enable = true;
    dbus.packages = [ pkgs.gcr ];
    udev.packages = [
      pkgs.yubikey-personalization
    ];
  };

  # YubiKey as an alternative to the password in PAM (sudo, swaylock, ...).
  # "sufficient" means the password always works as fallback, so a missing
  # or unenrolled key can never lock us out.
  security.pam.u2f = {
    enable = true;
    control = "sufficient";
    settings.cue = true;
  };
}
