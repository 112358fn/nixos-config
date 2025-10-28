{ config, pkgs, ... }: {
  imports = [
    ./nextcloud.nix
    ./jellyfin.nix
    ./actual.nix
    ./network.nix
    ./nginx.nix
    ./cloudflare.nix
    ./ssh.nix
    ];
  system.stateVersion = "23.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
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
  };
  time.timeZone = "Europe/Stockholm";
}
