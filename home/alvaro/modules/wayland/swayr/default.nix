{ ... }:
{
  programs.swayr = {
    enable = true;
    systemd.enable = true;
  };
  xdg.configFile."swayr/config.toml".source = ./config.toml;
}
