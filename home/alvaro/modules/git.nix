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
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
    };
    includes = [
      {
        condition = "gitdir:~/Developer/forge.skygrid.ai/";
        contents = {
          user = {
            email = "alvaro.alonso@skygrid.ai";
            signingkey = "~/.ssh/id_ed25519_sk_rk_forge.skygrid.ai";
          };
        };
      }
    ];
  };
  home.packages = [ pkgs.ghq ];
  home.sessionVariables.GHQ_ROOT = "$HOME/Developer";
}
