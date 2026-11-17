{ pkgs, inputs, noctalia, ... }:
{
  imports = [
    noctalia.nixosModules.default
  ];

  # Portals are owned by the system: programs.sway/niri enable them (incl. the
  # wlr portal and the sway routing from wlroots-portals.conf), and the systemd
  # user units that actually launch them come from here.
  nixpkgs.overlays = [ inputs.self.overlays.xdg-desktop-portal-wlr ];
  xdg.portal.xdgOpenUsePortal = true;
  programs = {
    noctalia.enable = true;
    # The only sway binary; home-manager just writes the config
    # (wayland.windowManager.sway.package = null).
    sway = {
      enable = true;
      xwayland.enable = true;
      extraPackages = [ ];
      wrapperFeatures = {
        base = false;
        gtk = true;
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
