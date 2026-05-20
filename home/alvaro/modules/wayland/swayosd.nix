{ pkgs, ... }:
{
  services.swayosd.enable = true;
  home.packages = [
    pkgs.brightnessctl
    pkgs.playerctl
  ];
  xdg.configFile."sway/config.d/3_mediacontrols".text = ''
    bindsym XF86AudioLowerVolume exec --no-startup-id swayosd-client --output-volume lower
    bindsym XF86AudioMute exec --no-startup-id swayosd-client --output-volume mute-toggle
    bindsym XF86AudioRaiseVolume exec --no-startup-id swayosd-client --output-volume raise
    bindsym XF86MonBrightnessDown exec --no-startup-id swayosd-client --brightness=lower
    bindsym XF86MonBrightnessUp exec --no-startup-id swayosd-client --brightness=raise

    bindsym XF86AudioPlay exec swayosd-client --playerctl play-pause
    bindsym XF86AudioNext exec swayosd-client --playerctl next
    bindsym XF86AudioPrev exec swayosd-client --playerctl prev
  '';
}
