{ pkgs, ... }:
{
  home.packages = [ pkgs.wlogout ];
  wayland.windowManager.sway.config.keybindings = {
    "XF86PowerOff" = "exec wlogout";
  };
}
