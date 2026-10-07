{ pkgs, ... }:
{
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "LG Electronics LG ULTRAFINE 510NTXRKN938";
            status = "enable";
            scale = 2.0;
            mode = "6144x3456@60.021";
          }
        ];
      }
      {
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "ASUSTek COMPUTER INC PA27JCV SBLMSB008701";
            status = "enable";
            scale = 2.0;
          }
        ];
      }
      {
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            scale = 2.0;
            mode = "2880x1920@60.001";
          }
        ];
      }
    ];
  };
  home.packages = [ pkgs.wdisplays ];
}
