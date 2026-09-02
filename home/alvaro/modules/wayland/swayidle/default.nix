{ pkgs, ... }:
{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 330;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events.before-sleep = "${pkgs.swaylock}/bin/swaylock -f";
  };
}
