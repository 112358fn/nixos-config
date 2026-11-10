{ ... }:
{
  imports = [ 
#  ./sway-noshell.nix
  ./noctalia.nix
  ];
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
