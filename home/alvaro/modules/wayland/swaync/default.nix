{ ... }:
{
  services.swaync.enable = true;
  xdg.configFile."sway/config.d/3_notifications".text = ''
    set $nc swaync-client -t -sw
    bindsym $mod+Shift+n exec $nc
  '';
}
