{pkgs, ... }: {
  
  environment.systemPackages = with pkgs; [
    wofi
    killall
    hyprpaper
    hyprshot
    swaynotificationcenter
    brightnessctl
    networkmanagerapplet
    pavucontrol
    blueberry
    whitesur-gtk-theme
    whitesur-icon-theme
    whitesur-cursors
    nwg-look
    nautilus
    gnome-calendar
    gnome-contacts
    gnome-online-accounts-gtk
  ];
  environment.sessionVariables = {
    GSK_RENDERER = "ngl";
    NIXOS_OZONE_WL = "1";
  };
  programs = {
    hyprland.enable = true;
    hyprland.withUWSM = true;
    hyprlock.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs;[
        i3status-rust
        tofi
        font-awesome
        swayidle
        swaylock
      ];
    };
    waybar.enable = true;
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
