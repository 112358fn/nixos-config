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
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraConfigEarly = "include ~/.config/sway/config.d/*";
    config = null;
  };
  programs.swaylock = {
    enable = true;
    settings = {
      indicator-radius = 100;
      ignore-empty-password = true;
      image = "${config.xdg.configHome}/backgrounds/shaded_landscape_blur.png";
      scaling = "fill";
    };
  };
  services = {
    swaync.enable = true;
    swayosd.enable = true;
    swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
        {
          timeout = 600;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
      ];
    };
  };
  home.packages = with pkgs; [
    brightnessctl
    wl-clipboard
    nautilus
    geary
    gnome-calendar
    gnome-contacts
    gnome-online-accounts-gtk
    gnome-font-viewer
    pavucontrol
  ];
}
