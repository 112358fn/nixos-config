{
  pkgs,
  inputs,
  config,
  lib,
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
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault { "Mod4+Ctrl+q" = "exec ${pkgs.systemd}/bin/systemctl suspend"; };
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
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg \"output * power off\"";
      }
    ];
    events = [
      {
        event = "after-resume";
        command = "${pkgs.sway}/bin/swaymsg \"output * power on\"";
      }
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
    ];
  };
}
