{ pkgs, ... }: {
  imports = [
    ./gpg.nix
  ];

  xdg.enable = true;

  home = {
    stateVersion = "23.05";

    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };

  programs.home-manager.enable = true;
}
