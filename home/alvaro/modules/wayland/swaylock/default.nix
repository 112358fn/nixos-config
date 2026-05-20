{ ... }:
{
  programs.swaylock = {
    enable = true;
    settings = { };
  };
  xdg.configFile."swaylock/config".source = ./config;
  # We are not using the logind because of
  # https://whynothugo.nl/journal/2022/10/26/systemd-locking-and-sleeping/
  xdg.configFile."sway/config.d/3_lock".text = ''
    set $lock pgrep swaylock || swaylock -f && systemctl suspend
    bindswitch --locked lid:on exec $lock
    bindsym --locked Mod1+Ctrl+q exec $lock
  '';
}
