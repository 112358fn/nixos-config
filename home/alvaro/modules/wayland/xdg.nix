{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = "wlr";
    xdgOpenUsePortal = true;
  };

  xdg.mimeApps.enable = true;

  home.packages = with pkgs; [
    xdg-utils
  ];
}
