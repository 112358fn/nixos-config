{ pkgs, ... }:
{
  programs = {
    niri.enable = true;
    sway = {
      enable = true;
      xwayland.enable = false;
      extraPackages = [ ];
      wrapperFeatures = {
        base = false;
        gtk = false;
      };
    };
    regreet = {
      enable = true;
      settings.GTK.application_prefer_dark_theme = true;
      font = {
        package = pkgs.adwaita-fonts;
        name = "Adwaita Sans Bold";
        size = 11;
      };
    };
  };
  services.greetd = {
    enable = true;
    settings.initial_session = {
      command = "sway";
      user = "alvaro";
    };
  };

}
