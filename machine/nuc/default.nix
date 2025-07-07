{ config, pkgs, ... }: {
  imports = [
    ./nextcloud.nix
    ./jellyfin.nix
    ./actual.nix
    ./network.nix
    ./nginx.nix
    ./tailscale.nix
    ./cloudflare.nix
    ];
  system.stateVersion = "23.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  programs = {
    i3lock = {
      enable = true;
      package = pkgs.i3lock-color;
    };
    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.i3lock-color}/bin/i3lock --blur 5 --nofork --ignore-empty-password";
    };
  };
  # XDG Portal is needed for flatpak
  xdg.portal = {
    enable = true;
    config.common.default = "gtk";
    extraPortals = [
     pkgs.xdg-desktop-portal-gtk
    ];
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
    # Flatpak is used to install zen browser
    # until it is included in nixpkgs
    flatpak.enable = true;
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status-rust
        ];
      };
    };
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
      extraConfig = ''
        StreamLocalBindUnlink yes
      '';
    };
  };
  time.timeZone = "Europe/Stockholm";
}
