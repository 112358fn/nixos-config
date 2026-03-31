{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  xdg.configFile = {
    "backgrounds/shaded_landscape.png".source = ./backgrounds/shaded_landscape.png;
    "backgrounds/shaded_landscape_blur.png".source = ./backgrounds/shaded_landscape_blur.png;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = "wlr";
    xdgOpenUsePortal = true;
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplicationPackages = with pkgs; [
      firefox
      papers
      loupe
    ];
  };
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraConfigEarly = "include ~/.config/sway/config.d/*";
    config = null;
    systemd.variables = [ "--all" ];
    xwayland = false;
  };
  programs = {
    swaylock = {
      enable = true;
      settings = { };
    };
    swayr = {
      enable = true;
      systemd.enable = true;
    };
    waybar = {
      enable = true;
      systemd.enable = true;
    };
    foot = {
      enable = true;
      server.enable = true;
    };
  };
  services = {
    swaync.enable = true;
    swayosd.enable = true;
    kanshi.enable = true;
    swayidle.enable = true;
    udiskie.enable = true;
  };
  home.packages = with pkgs; [
    rofi
    wlogout
    xdg-utils
    wdisplays
    nwg-look
    gnome-themes-extra
    adwaita-icon-theme
    brightnessctl
    wl-clipboard
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
    blueberry
    slurp
    grim
  ];
}
