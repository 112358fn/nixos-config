{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "Alvaro Alonso Bivou";
      };
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      branch = {
        sort = "-committerdate";
      };
    };
  };
  home.packages = [ pkgs.ghq ];
  home.sessionVariables.GHQ_ROOT = "$HOME/Developer";
}
