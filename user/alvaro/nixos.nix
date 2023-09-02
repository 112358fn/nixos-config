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
    tmux.enable = true;
    zsh.enable = true;
    starship.enable = true;
    firefox.enable = true;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "FiraCode" "DroidSansMono" ]; })
    lato
  ];
}
