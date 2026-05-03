{ ... }:
{
  programs.wofi.enable = true;
  xdg.configFile."sway/config.d/3_menu".text = ''
    bindsym $mod+d exec $menu
    set $menu pkill --exact wofi || wofi --show=drun
  '';
}
