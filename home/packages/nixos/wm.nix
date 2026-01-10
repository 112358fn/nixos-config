{ pkgs, inputs, config, ... }:
{
  xdg.configFile."backgrounds/shaded_landscape.png".source= ./backgrounds/shaded_landscape.png;
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    wrapperFeatures.gtk = true;
    config = {
      terminal = "${pkgs.ghostty}/bin/ghostty";
      output."*".bg = "${config.xdg.configHome}/backgrounds/shaded_landscape.png fill";
    };
  };
}
