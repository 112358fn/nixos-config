{ ... }:
{
  programs.swaylock = {
    enable = true;
    settings = { };
  };
  xdg.configFile."swaylock/config".source = ./config;
  xdg.configFile."sway/config.d/3_lock".text = ''
    bindsym --locked Mod1+Ctrl+q exec swaylock -f
  '';
}
