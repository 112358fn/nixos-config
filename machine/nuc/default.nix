{ config, pkgs, ... }: {
  imports = [
    ./nextcloud.nix
    ./jellyfin.nix
    ./actual.nix
    ./network.nix
    ./nginx.nix
    ./cloudflare.nix
    ./ssh.nix
    ./taskchampion.nix
    ./tailscale.nix
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

  services = {
    mattermost = {
      enable = true;
      mutableConfig = true;
      preferNixConfig = false;
      siteUrl = "https://chat.opstackle.ai";
      database.peerAuth = true;
      database.socketPath = "/run/postgresql";
      database.host = "127.0.0.1";
    };
    nginx.virtualHosts."chat.opstackle.ai" = {
      serverName = "chat.opstackle.ai";
      serverAliases = ["chat.opstackle.dev" "chat.opstackle.xyz"];
      forceSSL = false;
      addSSL = true;
      enableACME = true;
      locations."~ /api/v[0-9]+/(users/)?websocket$" = {
        proxyPass = "http://127.0.0.1:8065$request_uri";
        proxyWebsockets = true;
        recommendedProxySettings = true;
      };
      locations."/" = {
        proxyPass = "http://127.0.0.1:8065$request_uri";
        recommendedProxySettings = true;
        extraConfig = ''
          client_max_body_size 100M;
        '';
      };
    };
  };

}
