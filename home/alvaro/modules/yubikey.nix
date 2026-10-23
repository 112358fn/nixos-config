{ pkgs, ... }:
{
  home.packages = with pkgs; [
    yubikey-manager
    pam_u2f # provides pamu2fcfg to enroll the key
    unstable.yubikey-touch-detector
  ];

  # Notifies when the YubiKey is waiting for a touch (gpg, ssh, u2f, pam)
  systemd.user.services.yubikey-touch-detector = {
    Unit = {
      Description = "Detects when your YubiKey is waiting for a touch";
      After = "graphical-session.target";
      ConditionEnvironment = "WAYLAND_DISPLAY";
      PartOf = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      Restart = "on-failure";
      ExecStart = "${pkgs.unstable.yubikey-touch-detector}/bin/yubikey-touch-detector --notify";
    };
  };
}
