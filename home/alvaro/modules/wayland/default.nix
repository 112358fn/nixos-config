{ ... }:
{
  imports = [ 
  ./kanshi
  ./sway
  ./swayidle
  ./swaylock
  ./swaync
  ./swayr
  ./waybar
  ./wlogout
  ./wofi
  ./gtk.nix
  ./kdeconnect.nix
  ./webcam.nix
  ./screenshot.nix
  ./swayosd.nix
  ./terminal.nix
  ./xdg.nix
  ];
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
