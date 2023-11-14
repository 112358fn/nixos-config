{ pkgs, ... }: {
  users.users.alvaro = {
    isNormalUser = true;
    home = "/home/alvaro";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;

    packages = with pkgs; [
      git
      ghq
      zk
      pass
      helix
      starship
      bat
      eza
      fzf
      ripgrep
      yadm
      gnupg
    ];
  };

  programs = {
    fish.enable = true;
    direnv.enable = true;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "FiraCode" "DroidSansMono" ]; })
    lato
  ];
}
