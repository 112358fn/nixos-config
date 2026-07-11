{ ... }:
{
  programs.ghostty = {
    enable = true;
    systemd.enable = false;
    enableBashIntegration = true;
  };

  programs.foot = {
    enable = true;
    server.enable = true;
  };
  #programs.zellij = {
  #  enable = true;
  #  enableFishIntegration = true;
  #  attachExistingSession = true;
  #  exitShellOnExit = true;
  #};
  xdg.configFile."sway/config.d/4_terminal".text = ''
    assign [app_id="footclient"] workspace $
    bindsym $mod+grave exec 'swaymsg "[app_id=footclient] nop" || footclient -N && swaymsg "workspace \$"'
    bindsym $mod+return exec 'footclient -N'
  '';
  home.sessionVariables.TERMINAL = "footclient";
}
