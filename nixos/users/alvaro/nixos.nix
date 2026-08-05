{ pkgs, lib, ... }:
{
  users.users.alvaro = {
    isNormalUser = true;
    home = "/home/alvaro";
    extraGroups = [
      "audio"
      "wheel"
      "networkmanager"
      "dialout"
      "docker"
      "hidraw"
      "i2c"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDfDofWEXwuMRtaXI4Vk6/hla4w53/gMbvknPc7CSaFC3sv4gqBogreWJyJ62ZpwnClxhmM9k4J2gdkZlV56m3gbbKaLaLCSOjPoLYMy+2ruiyRrfhSHFJFFJJCBKgPN9GSE3xi53j4WFPCOZ6prA6EzRzYAWV0sZsoIHo9NEI6kdkWa8d7lH43zPcL9+qIA9hwPs2cZ/1YMXFSGeLpJPpNv0F7JGgqLtWY1kN7dd1jMPAwM1hFCi9SQj0SNurntT8WNlsZoJks+c3OvFzvgfFgHSOOjSacjFNRJE1qi8BWjK++cA2940hj1the3CKFA8c8PVMM6zWOHIR/Y6W3V0YFQj3/SIldFFLrr4OffOHTNMZsrRaVK1zWpUPRGYNNW4AUBh37eUvUkkSv8BRwU4snZzBT3FVLJZMpVkWUOjPHmFeoS9DQ9CrI1uaArYMrj/i+O2c9ntZWyZ97hVHWx8n3OkwkOfC2UeSNOuW2RIbODGH7vPZnHJhrYxMDynwh3dIVkdwdDbxIbUCl+s9Fu9fofKf5FeAYkWpY1cBQpKOh2U5hR/42O0i76RlVAsom361NfZ+Sx25RkHQ5p6yKJ4m8zYypmwf8WdsnIXd8xJxxd8j4we4YsCR2AbCY/UVx+S2/L6BmidqqbHF11UZU2azD5VOOiazLNhyCrUsRk9LYkw== cardno:23_869_830"
    ];
  };
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
