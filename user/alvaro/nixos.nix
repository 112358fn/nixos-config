{ pkgs, ... }:

{
  users.users.alvaro = {
    isNormalUser = true;
    home = "/home/alvaro";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };
}
