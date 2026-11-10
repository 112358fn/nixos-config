{ ... }:
{
  services.swaync = {
    enable = true;
    settings = {
      # overlay sits above fullscreen windows in sway; "top" (the control-center default) does not
      layer = "overlay";
      control-center-layer = "overlay";
    };
  };
  wayland.windowManager.sway.config.keybindings = {
    "$mod+Shift+n" = "exec \"swaync-client -t -sw\"";
  };
}
