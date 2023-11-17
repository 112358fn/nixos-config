{pkgs, ...}: {
  environment.systemPackages = [pkgs.godns];

  systemd.services = {
    godns-cloud = {
      unitConfig = {
        Description="GoDNS Service";
        After="network.target";
      };
      serviceConfig = {
        ExecStart="${pkgs.godns}/bin/godns -c=/root/godns/cloud.json";
        Restart="always";
        KillMode="process";
        RestartSec="2s";
      };
      wantedBy = ["multi-user.target"];
    };

    godns-media = {
      unitConfig = {
        Description="GoDNS Service";
        After="network.target";
      };
      serviceConfig = {
        ExecStart="${pkgs.godns}/bin/godns -c=/root/godns/media.json";
        Restart="always";
        KillMode="process";
        RestartSec="2s";
      };
      wantedBy = ["multi-user.target"];
    };
    
  };
}
