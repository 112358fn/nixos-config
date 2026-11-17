{ config, pkgs, ... }:
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
    nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
  };

  # nixpkgs' nautilus only loads extensions from this dir; the GNOME NixOS
  # module sets it, sway doesn't. Needed for nautilus-python (Nextcloud
  # sync-state emblems and share menu).
  home.sessionVariables.NAUTILUS_4_EXTENSION_DIR =
    "${config.home.profileDirectory}/lib/nautilus/extensions-4";

  home.packages = with pkgs; [
    gnome-themes-extra
    nautilus
    nautilus-python
    nextcloud-client
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
