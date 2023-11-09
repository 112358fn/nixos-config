{pkgs, ...}: {
  environment.systemPackages = [pkgs.godns];

  systemd.services.godns = {
    unitConfig = {
      Description="GoDNS Service";
      After="network.target";
    };
    serviceConfig = {
      ExecStart="${pkgs.godns}/bin/godns -c=/root/config.json";
      Restart="always";
      KillMode="process";
      RestartSec="2s";
    };
    wantedBy = ["multi-user.target"];
  };
}