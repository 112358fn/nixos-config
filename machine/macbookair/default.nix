{ config, pkgs, ... }:

{
  system.stateVersion = "23.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "macbookair";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    xss-lock
    i3lock-color
    i3status-rust
  ];
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
      windowManager.i3.enable = true;
      displayManager.gdm.enable = true;
    };
    pcscd.enable = true;
    dbus.packages = [ pkgs.gcr ];
    logind.extraConfig = ''
      HandlePowerKey=ignore
      HoldoffTimeoutSec=0s
    '';
    # udev.extraRules = ''
    #   ACTION=="change", SUBSYSTEM=="drm", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/run/user/1000/gdm/Xauthority", RUN+="${pkgs.xorg.xrandr}/bin/xrandr --auto"
    # '';
  };

  time.timeZone = "Europe/Stockholm";
}

