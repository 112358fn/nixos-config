{ ... }:
{
  programs.ghostty = {
    enable = true;
    systemd.enable = false;
    enableBashIntegration = true;
  };

  programs.foot = {
    enable = true;
  };
  #programs.zellij = {
  #  enable = true;
  #  enableFishIntegration = true;
  #  attachExistingSession = true;
  #  exitShellOnExit = true;
  #};
  xdg.configFile."sway/config.d/4_terminal".text = ''
    assign [app_id="^foot$"] workspace $
    assign [app_id="^foot-main$"] workspace $
    bindsym $mod+grave exec 'swaymsg "[app_id=foot-main] nop" || foot --app-id=foot-main -- tmux new-session -A -s main && swaymsg "workspace \$"'
    bindsym $mod+return exec 'foot'
  '';
  home.sessionVariables.TERMINAL = "foot";
}
