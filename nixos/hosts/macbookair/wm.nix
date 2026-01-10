{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    blueberry
    whitesur-gtk-theme
    whitesur-icon-theme
    whitesur-cursors
    nwg-look
    nautilus
    gnome-calendar
    gnome-contacts
    gnome-online-accounts-gtk
    firefox
  ];
  environment.sessionVariables = {
    GSK_RENDERER = "ngl";
    NIXOS_OZONE_WL = "1";
  };
  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        waybar
        tofi
        swayidle
        swaylock
        swaynotificationcenter
        brightnessctl
        pavucontrol
        killall
        wl-clipboard
      ];
    };
    geary.enable = true;
  };
  # Flatpak is used to install zen browser
  # until it is included in nixpkgs
  services.flatpak.enable = true;
  # Evolution data server is used
  # by calendar and notes
  services.gnome.evolution-data-server.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
