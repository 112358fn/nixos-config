{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    jellyfin-ffmpeg
  ];
  services = {
    jellyfin = {
      enable = true;
    };
    nginx.virtualHosts."media.alonsobivou.com" = {
        serverName = "media.alonsobivou.com";
        forceSSL = false;
        addSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8096$request_uri";
          recommendedProxySettings = true;
        };
      };
  };
}
