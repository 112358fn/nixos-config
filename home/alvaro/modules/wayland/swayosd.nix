{ pkgs, ... }:
{
  # Alternative: https://github.com/System64fumo/syshud
  services.swayosd.enable = true;
  home.packages = [
    pkgs.brightnessctl
    pkgs.playerctl
  ];
  wayland.windowManager.sway.config.keybindings = {
    "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume raise";
    "XF86AudioLowerVolume" = "exec swayosd-client --output-volume lower";
    "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
    "XF86MonBrightnessUp" = "exec swayosd-client --brightness raise";
    "XF86MonBrightnessDown" = "exec swayosd-client --brightness lower";
    "XF86AudioPlay" = "exec swayosd-client --playerctl play-pause";
    "XF86AudioNext" = "exec swayosd-client --playerctl next";
    "XF86AudioPrev" = "exec swayosd-client --playerctl prev";
  };

}
