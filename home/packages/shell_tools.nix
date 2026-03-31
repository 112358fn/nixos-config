{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pass
    zellij
    eza
    ripgrep
    fzf
    yazi
    yadm
    chezmoi
    gnused
    zk
    taskwarrior3
    ghq
    git
    fswatch
    rclone
    duckdb
    powertop
    jq
    yq
    uv
  ];
  programs = {
    starship.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    helix = {
      enable = true;
      defaultEditor = true;
    };
    bat = {
      enable = true;
      themes = {
        catppuccin = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
            sha256 = "lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
          };
          file = "themes/Catppuccin Mocha.tmTheme";
        };
      };
    };
  };
}
