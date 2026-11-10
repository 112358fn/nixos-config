{ ... }:
{
  programs.swaylock = {
    enable = true;
    settings = { };
  };
  xdg.configFile."swaylock/config".source = ./config;
  wayland.windowManager.sway.config.keybindings = {
    "Mod1+Ctrl+q" = "exec swaylock -f";
  };
}
