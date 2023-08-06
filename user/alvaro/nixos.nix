{ pkgs, ... }: {
  users.users.alvaro = {
    isNormalUser = true;
    home = "/home/alvaro";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "FiraCode" "DroidSansMono" ]; })
    lato
  ];
}
