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
  xdg.configFile."sway/config.d/4_terminal".text = "bindsym $mod+Return exec footclient";
  home.sessionVariables.TERMINAL = "footclient";
}
