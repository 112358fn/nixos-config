{ pkgs, inputs, noctalia, ... }:
{
  imports = [
    noctalia.nixosModules.default
  ];

  nixpkgs.overlays = [ inputs.self.overlays.xdg-desktop-portal-wlr ];
  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.config.sway."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
  services.gnome.gnome-keyring.enable = true;
  programs = {
    noctalia.enable = true;
    sway = {
      enable = true;
      extraPackages = [ ];
      wrapperFeatures.gtk = true;
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
