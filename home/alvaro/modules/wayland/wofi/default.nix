{ ... }:
{
  programs.wofi = {
    enable = true;
    settings.layer = "overlay";
  };
  xdg.configFile."sway/config.d/3_menu".text = ''
    set $menu pkill wofi || wofi --show=drun
    bindsym $mod+d exec $menu
  '';
}
