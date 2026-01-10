{
  pkgs,
  inputs,
  config,
  ...
}:
{
  xdg.configFile = {
    "backgrounds/shaded_landscape.png".source = ./backgrounds/shaded_landscape.png;
    "backgrounds/shaded_landscape_blur.png".source = ./backgrounds/shaded_landscape_blur.png;
  };
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    wrapperFeatures.gtk = true;
    config = {
      terminal = "${pkgs.ghostty}/bin/ghostty";
      output."*".bg = "${config.xdg.configHome}/backgrounds/shaded_landscape.png fill";
    };
  };
  programs.swaylock = {
    enable = true;
    settings = {
      indicator-radius = 100;
      ignore-empty-password = true;
      image = "${config.xdg.configHome}/backgrounds/shaded_landscape_blur.png";
      scaling = "fill";
    };
  };
}
