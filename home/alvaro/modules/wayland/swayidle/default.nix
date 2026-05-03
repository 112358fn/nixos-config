{ ... }:
{
  services.swayidle.enable = true;
  xdg.configFile."swayidle/config".source = ./config;
}
