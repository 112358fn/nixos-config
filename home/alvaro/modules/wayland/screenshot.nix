{ pkgs, ... }:
{

  home.packages = with pkgs; [
    slurp
    grim
  ];
  wayland.windowManager.sway.config.keybindings = {
    "Mod1+Shift+5" = "exec \"slurp | grim -g - - | wl-copy\"";
  };
}
