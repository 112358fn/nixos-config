{ pkgs, ... }: {
  users.users.admin = {
    isNormalUser = true;
    home = "/home/admin";
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
