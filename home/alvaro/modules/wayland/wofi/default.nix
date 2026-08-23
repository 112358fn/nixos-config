{ ... }:
{
  programs.wofi.enable = true;
  xdg.configFile."sway/config.d/3_menu".text = ''
    set $menu pkill wofi || wofi --show=drun
    bindsym $mod+d exec $menu
  '';
}
