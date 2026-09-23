{ ... }:
{
  services.swaync = {
    enable = true;
    settings = {
      # overlay sits above fullscreen windows in sway; "top" (the control-center default) does not
      layer = "overlay";
      control-center-layer = "overlay";
    };
  };
  xdg.configFile."sway/config.d/3_notifications".text = ''
    set $nc swaync-client -t -sw
    bindsym $mod+Shift+n exec $nc
  '';
}
