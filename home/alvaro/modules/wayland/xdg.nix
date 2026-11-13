{ pkgs, ... }:
{
  # Portals are configured system-wide in nixos/hosts/framework/wayland.nix.
  xdg.mimeApps.enable = true;

  home.packages = with pkgs; [
    xdg-utils
  ];
}
