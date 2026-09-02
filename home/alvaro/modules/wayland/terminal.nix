{ ... }:
{
  programs.foot = {
    enable = true;
  };
  xdg.configFile."sway/config.d/4_terminal".text = ''
    assign [app_id="^foot$"] workspace $
    bindsym $mod+grave exec 'swaymsg "[app_id=foot] nop" || foot && swaymsg "workspace \$"'
    bindsym $mod+return exec 'foot'
  '';
  home.sessionVariables.TERMINAL = "foot";
}
