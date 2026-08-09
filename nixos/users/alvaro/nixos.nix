{ pkgs, lib, ... }:
{
  imports = [ ./base.nix ];

  users.users.alvaro.extraGroups = [
    "dialout"
    "docker"
    "hidraw"
    "i2c"
  ];
  users.groups.hidraw = {};

  programs.dconf.enable = true;
  # Needed to use uv
  # https://nix.dev/guides/faq#how-to-run-non-nix-executables
  programs.nix-ld.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    noto-fonts-color-emoji
    lato
    adwaita-fonts
  ];
  security = {
    polkit.enable = true;
    pam.services.swaylock = { };
  };
  services = {
    # Map CapsLock to Esc on single press and Ctrl on when used with multiple keys.
    interception-tools = {
      enable = true;
      plugins = [ pkgs.interception-tools-plugins.caps2esc ];
      # Work around until the path to the plugin is fixed in upstream
      udevmonConfig = ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';
    };
    pcscd.enable = true;
    dbus.packages = [ pkgs.gcr ];

    # Evolution data server is used
    # by calendar and notes
    gnome.evolution-data-server.enable = true;
    gnome.gnome-keyring.enable = true;
    gnome.gnome-online-accounts.enable = true;

    # Autostart sway
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "sway";
          user = "alvaro";
        };
        initial_session = {
          command = "sway";
          user = "alvaro";
        };
      };
    };
    # D-BUS service to manipulate storage devs
    udisks2.enable = true;
    # Tailscale
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
    # Upower
    upower.enable = true;
    udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", GROUP="hidraw", MODE="0660"
    '';
  };
  powerManagement.powertop.enable = true;
  systemd.services.tailscaled.wantedBy = lib.mkForce [ ];
}
