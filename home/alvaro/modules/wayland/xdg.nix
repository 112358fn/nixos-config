{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    # https://github.com/emersion/xdg-desktop-portal-wlr/blob/master/contrib/wlroots-portals.conf
    # https://github.com/emersion/xdg-desktop-portal-wlr/pull/315
    config.sway = {
      # Use xdg-desktop-portal-gtk for every portal interface...
      default = "gtk";
      # ... except for the ScreenCast, Screenshot and Secret
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "wlr";
      # ignore inhibit bc gtk portal always returns as success,
      # despite sway/the wlr portal not having an implementation,
      # stopping firefox from using wayland idle-inhibit
      "org.freedesktop.impl.portal.Inhibit" = "none";
    };
    xdgOpenUsePortal = true;
  };

  xdg.mimeApps.enable = true;

  home.packages = with pkgs; [
    xdg-utils
  ];
}
