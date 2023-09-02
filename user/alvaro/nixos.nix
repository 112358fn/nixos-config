{ pkgs, ... }: {
  users.users.alvaro = {
    isNormalUser = true;
    home = "/home/alvaro";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;

    packages = with pkgs; [
      git
      pass
      helix
      alacritty
      starship
      vscode
      firefox
      bat
      fzf
      ripgrep
      texlive.combined.scheme-full
      nixpkgs-fmt
      xss-lock
      i3lock-color
    ];
  };

  programs = {
    zsh.enable = true;
    firefox.enable = true;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "FiraCode" "DroidSansMono" ]; })
    lato
  ];
}
