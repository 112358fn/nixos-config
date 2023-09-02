{ pkgs, ... }: {
  imports = [
    ./alacritty
    ./nvim.nix
    ./gpg.nix
    ./git.nix
    ./zsh.nix
  ];

  xdg.enable = true;

  home = {
    stateVersion = "23.05";

    packages = with pkgs; [
      firefox
      bat
      fzf
      ripgrep
      texlive.combined.scheme-full
      nixpkgs-fmt
      xss-lock
      i3lock-color
    ];

    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };

  programs.home-manager.enable = true;
  programs.password-store.enable = true;
  programs.vscode.enable = true;
}
