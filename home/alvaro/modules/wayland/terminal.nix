{ ... }:
{
  programs.ghostty = {
    enable = true;
    systemd.enable = true;
    enableBashIntegration = true;
  };

  programs.foot = {
    enable = true;
    server.enable = true;
  };
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    attachExistingSession = true;
    exitShellOnExit = true;
  };
  xdg.configFile."sway/config.d/4_terminal".text = ''
    for_window [app_id="footclient"] move scratchpad
    bindsym $mod+grave exec 'swaymsg "[app_id=footclient] nop" || footclient -N && swaymsg "[app_id=footclient] scratchpad show, resize set 100ppt 100ppt, move position 0 0"'
  '';
  home.sessionVariables.TERMINAL = "footclient";
}
