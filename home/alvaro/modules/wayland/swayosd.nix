{ pkgs, ... }:
let
  # swayosd-client adjusts exactly one backlight per call (default: the
  # internal panel); prefer the external monitor when it's attached —
  # ddcci-rescan detaches stale ddcci devices on undock, so existence
  # implies presence.
  brightness = pkgs.writeShellScript "brightness-osd" ''
    # route on connector state, not backlight-device existence: the ddcci
    # device deliberately stays attached while undocked (see ddcci.nix), and
    # kanshi turns the internal panel off when the external one is connected.
    # -DP-* never matches eDP (its hyphen sits before the "e").
    if grep -q '^connected' /sys/class/drm/card*-DP-*/status 2>/dev/null \
        && ls /sys/class/backlight/ddcci*/brightness >/dev/null 2>&1; then
      exec swayosd-client --brightness="$1" --device 'ddcci*'
    fi
    exec swayosd-client --brightness="$1"
  '';
in
{
  # Alternative: https://github.com/System64fumo/syshud
  services.swayosd.enable = true;
  home.packages = [
    pkgs.brightnessctl
    pkgs.playerctl
  ];
  xdg.configFile."sway/config.d/3_mediacontrols".text = ''
    bindsym XF86AudioLowerVolume exec --no-startup-id swayosd-client --output-volume lower
    bindsym XF86AudioMute exec --no-startup-id swayosd-client --output-volume mute-toggle
    bindsym XF86AudioRaiseVolume exec --no-startup-id swayosd-client --output-volume raise
    bindsym XF86MonBrightnessDown exec --no-startup-id ${brightness} lower
    bindsym XF86MonBrightnessUp exec --no-startup-id ${brightness} raise

    bindsym XF86AudioPlay exec swayosd-client --playerctl play-pause
    bindsym XF86AudioNext exec swayosd-client --playerctl next
    bindsym XF86AudioPrev exec swayosd-client --playerctl prev
  '';
}
