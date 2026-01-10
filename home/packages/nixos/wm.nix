{ pkgs, inputs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      terminal = "${pkgs.ghostty}/bin/ghostty";
    };
  };
}
