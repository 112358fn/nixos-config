{ ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraConfigEarly = "include ~/.config/sway/config.d/*";
    config = null;
    systemd.variables = [ "--all" ];
    xwayland = false;
  };

  xdg.configFile = {
    "backgrounds/shaded_landscape.png".source = ./backgrounds/shaded_landscape.png;
    "backgrounds/shaded_landscape_blur.png".source = ./backgrounds/shaded_landscape_blur.png;
    "sway/config.d/1_style".source = ./config.d/1_style;
    "sway/config.d/2_input".source = ./config.d/2_input;
    "sway/config.d/3_bindings".source = ./config.d/3_bindings;
    "sway/config.d/4_exec".source = ./config.d/4_exec;
    "sway/config.d/5_assign".source = ./config.d/5_assign;
  };
  imports = [ ./focus-on-urgent.nix ];
}
