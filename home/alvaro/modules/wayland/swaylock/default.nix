{ ... }:
{
  programs.swaylock = {
    enable = true;
    settings = { };
  };
  xdg.configFile."swaylock/config".source = ./config;
  xdg.configFile."sway/config.d/3_lock".text = ''
    set $lock swaylock -f && systemctl suspend
    bindswitch --locked lid:toggle exec $lock
    bindsym Mod1+Ctrl+q exec $lock
  '';
}
