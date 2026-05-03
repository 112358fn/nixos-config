{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pass
    eza
    ripgrep
    fzf
    gnused
    gnumake
    zk
    taskwarrior3
    ghq
    git
    fswatch
    rclone
    duckdb
    powertop
    jq
    yq-go
    uv
    llm-agents.claude-code
    llm-agents.claude-code-acp
    dig
  ];
  xdg.enable = true;
  programs = {
    bash.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_autosuggestion_enabled 0
      '';
    };
    starship = {
      enable = true;
      enableBashIntegration = false;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
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
