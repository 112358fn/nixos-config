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
      alacritty
      starship
      firefox
      bat
      eza
      fzf
      ripgrep
#      texlive.combined.scheme-full
      nixpkgs-fmt
      xss-lock
      i3lock-color
      zellij
      python311Packages.python-lsp-server
      yadm
      gnupg
      pinentry-gtk2
    ];
  };

  programs = {
    fish.enable = true;
    firefox.enable = true;
    direnv.enable = true;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "FiraCode" "DroidSansMono" ]; })
    lato
  ];
}
