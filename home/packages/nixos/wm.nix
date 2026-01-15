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
    checkConfig = false;
    wrapperFeatures.gtk = true;
    config = {
      terminal = "${pkgs.ghostty}/bin/ghostty";
      output."*".bg = "${config.xdg.configHome}/backgrounds/shaded_landscape.png fill";
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "Mod4+Ctrl+q" = "exec ${pkgs.systemd}/bin/systemctl suspend";
          "${modifier}+Left" = null;
          "${modifier}+Down" = null;
          "${modifier}+Up" = null;
          "${modifier}+Right" = null;
          "XF86AudioRaiseVolume" =
            "exec --no-startup-id ${pkgs.swayosd}/bin/swayosd-client --output-volume raise";
          "XF86AudioLowerVolume" =
            "exec --no-startup-id ${pkgs.swayosd}/bin/swayosd-client --output-volume lower";
          "XF86AudioMute" =
            "exec --no-startup-id ${pkgs.swayosd}/bin/swayosd-client --output-volume mute-toggle";
          "XF86MonBrightnessUp" =
            "exec --no-startup-id ${pkgs.swayosd}/bin/swayosd-client --brightness=raise";
          "XF86MonBrightnessDown" =
            "exec --no-startup-id ${pkgs.swayosd}/bin/swayosd-client --brightness=lower";
          "${modifier}+Shift+n" = "exec ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
        };
    };
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
