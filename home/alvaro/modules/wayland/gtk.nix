{ pkgs, ... }:
{
  # Writes gtk-{2,3,4} settings and the org/gnome/desktop/interface dconf keys
  # (GTK on Wayland reads the latter through the settings portal).
  gtk = {
    enable = true;
    theme.name = "Adwaita";
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    font = {
      name = "Adwaita Sans Bold";
      size = 11;
      package = pkgs.adwaita-fonts;
    };
    colorScheme = "dark";
    # GTK4 ships Adwaita as its built-in theme (libadwaita apps ignore the
    # setting entirely); don't write the GTK3 theme name there.
    gtk4.theme = null;
  };

  # Single source for the cursor: GTK, XCURSOR_* and sway's seat config.
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 21;
    gtk.enable = true;
    sway.enable = true;
  };

  services = {
    udiskie.enable = true;
  };
  home.packages = with pkgs; [
    gnome-themes-extra
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
  ];
  xdg.mimeApps.defaultApplicationPackages = with pkgs; [
    papers
    loupe
  ];
}
