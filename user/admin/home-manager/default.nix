{ pkgs, ... }: {
  imports = [
    ./gpg.nix
  ];
  home = {
    stateVersion = "23.05";

    packages = with pkgs; [
      bat
      fzf
      ripgrep
      neovim
    ];

    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };

  programs.home-manager.enable = true;
}
