# Switch power-profiles-daemon profile on AC plug/unplug: performance on
# the adapter, power-saver on battery. Manual changes via powerprofilesctl
# still work until the next plug event.
{ pkgs, ... }:
let
  power-profile-sync = pkgs.writeShellScript "power-profile-sync" ''
    profile=power-saver
    for ps in /sys/class/power_supply/*; do
      if [ "$(cat "$ps/type" 2>/dev/null)" = Mains ] \
        && [ "$(cat "$ps/online" 2>/dev/null)" = 1 ]; then
        profile=performance
      fi
    done
    echo "setting power profile: $profile"
    ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set "$profile"
  '';
in
{
  services.power-profiles-daemon.enable = true;

  systemd.services.power-profile-sync = {
    description = "Set power profile from AC adapter state";
    after = [ "power-profiles-daemon.service" ];
    wants = [ "power-profiles-daemon.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${power-profile-sync}";
    };
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{type}=="Mains", RUN+="${pkgs.systemd}/bin/systemctl start --no-block power-profile-sync.service"
  '';

  # The adapter may have changed while asleep
  powerManagement.resumeCommands = ''
    ${pkgs.systemd}/bin/systemctl start --no-block power-profile-sync.service
  '';
}
