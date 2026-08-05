# DDC/CI brightness for external monitors: expose them as
# /sys/class/backlight/ddcci* so swayosd/brightnessctl (via logind) work.
# amdgpu on 6.x doesn't mark its buses I2C_CLASS_DDC, so ddcci never
# autoprobes; attach the 0x37 client ourselves and re-scan on DRM hotplug,
# because the AMDGPU aux i2c adapters exist from boot with or without a
# monitor behind them.
{ config, pkgs, ... }:
let
  # The upstream capability-string parser only matches a tag directly after
  # the previous ')'; the PA27JCV separates items with spaces, so the vcp
  # list is never found and the driver picks a bogus backlight control
  # (max_brightness=1). Patched until fixed upstream.
  ddcci-driver = config.boot.kernelPackages.ddcci-driver.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ./ddcci-capstr-whitespace.patch ];
  });
  ddcci-rescan = pkgs.writeShellScript "ddcci-rescan" ''
    set -u
    for attempt in 1 2 3; do
      pending=0
      for dev in /sys/bus/i2c/devices/i2c-*; do
        grep -q "^AMDGPU DM aux hw bus" "$dev/name" 2>/dev/null || continue
        bus=''${dev##*/i2c-}
        client="$dev/$bus-0037"
        # the aux adapter's parent is its DRM connector; skip the internal
        # panel (no DDC/CI, only slows the scan down with failed probes)
        conn=$(readlink -f "$dev/..")
        case "''${conn##*/}" in *eDP*) continue ;; esac
        # never detach on disconnect: the ddcci remove path leaks a dangling
        # /sys/class/backlight symlink that breaks swayosd's backend entirely.
        # An attached client on a disconnected port is harmless and re-docking
        # the same port reuses it; brightness keys route on connector status.
        [ "$(cat "$conn/status" 2>/dev/null)" = "connected" ] || continue
        if [ -e "$client" ]; then
          # attached; retry bind if the boot-time probe raced DP link training
          [ -e "$client/driver" ] && continue
          echo "$bus-0037" > /sys/bus/i2c/drivers/ddcci/bind 2>/dev/null \
            && echo "bound ddcci to $bus-0037" || pending=1
          continue
        fi
        if ${pkgs.ddcutil}/bin/ddcutil getvcp 10 --bus "$bus" --brief >/dev/null 2>&1; then
          echo ddcci 0x37 > "$dev/new_device" \
            && echo "attached ddcci to i2c-$bus" || pending=1
          # probe runs synchronously on attach and can fail while the DP
          # link is still training; retry the bind in the next round
          [ -e "$client/driver" ] || pending=1
        else
          pending=1
        fi
      done
      [ "$pending" = 0 ] && break
      sleep 2
    done
    exit 0
  '';
in
{
  boot = {
    extraModulePackages = [ ddcci-driver ];
    # ddcci-backlight pulls in ddcci; i2c-dev is needed for ddcutil probing
    kernelModules = [
      "ddcci-backlight"
      "i2c-dev"
    ];
  };

  # i2c group + /dev/i2c-* udev rule; only needed for interactive ddcutil
  # debugging — the rescan service runs as root.
  hardware.i2c.enable = true;

  environment.systemPackages = [ pkgs.ddcutil ];

  systemd.services.ddcci-rescan = {
    description = "Attach ddcci to DDC/CI-capable external monitors";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${ddcci-rescan}";
    };
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="i2c-dev", ATTR{name}=="AMDGPU DM aux*", TAG+="systemd", ENV{SYSTEMD_WANTS}+="ddcci-rescan.service"
    ACTION=="change", SUBSYSTEM=="drm", KERNEL=="card[0-9]*", RUN+="${pkgs.systemd}/bin/systemctl start --no-block ddcci-rescan.service"
  '';

  # DP links retrain on resume; kick a rescan explicitly (cheap + idempotent)
  powerManagement.resumeCommands = ''
    ${pkgs.systemd}/bin/systemctl start --no-block ddcci-rescan.service
  '';
}
