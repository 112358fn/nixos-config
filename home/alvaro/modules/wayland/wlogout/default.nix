{ pkgs, ... }:
{
  home.packages = [ pkgs.wlogout ];
  xdg.configFile."sway/config.d/0_logout.nix".text = "bindsym --no-repeat XF86PowerOff exec wlogout
";
}
