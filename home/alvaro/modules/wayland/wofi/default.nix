{ ... }:
{
  programs.wofi = {
    enable = true;
    settings.layer = "overlay";
  };

  wayland.windowManager.sway.config.keybindings = {
    "$mod+d" = "exec \"pkill wofi || wofi --show=drun\"";
  };
}
