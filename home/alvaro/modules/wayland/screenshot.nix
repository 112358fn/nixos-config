{ pkgs, ... }:
{

  home.packages = with pkgs; [
    wl-clipboard
    slurp
    grim
  ];
  xdg.configFile."sway/config.d/3_screenshot".text = ''

    set $screenshot slurp | grim -g - - | wl-copy
    bindsym Mod1+Shift+5 exec $screenshot
  '';
}
