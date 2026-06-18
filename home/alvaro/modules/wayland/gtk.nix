{ pkgs, ... }:
{
  services = {
    udiskie.enable = true;
  };
  home.packages = with pkgs; [
    nwg-look
    gnome-themes-extra
    adwaita-icon-theme
    nautilus
    file-roller
    geary
    gnome-calendar
    gnome-contacts
    gnome-online-accounts-gtk
    gnome-font-viewer
    papers
    snapshot
    loupe
    sushi
    pavucontrol
  ];
  xdg.mimeApps.defaultApplicationPackages = with pkgs; [
    papers
    loupe
  ];
}
