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
  programs.jujutsu = {
    enable = true;
    package = pkgs.unstable.jujutsu;
    settings.user.name = "Alvaro Alonso Bivou";
  };
  home.packages = with pkgs; [
    ghq
    forgejo-cli
    unstable.gitea-mcp-server
  ];
  # fj prints "Could not find keys file..." to stdout during the build,
  # which ends up on line 1 of the generated completions. Ship a cleaned
  # copy in ~/.config/fish/completions (takes precedence over vendor ones)
  # so forgejo-cli itself stays a binary-cache hit.
  xdg.configFile."fish/completions/fj.fish".source =
    pkgs.runCommand "fj.fish" { } ''
      sed '/^Could not find keys file/d' \
        ${pkgs.forgejo-cli}/share/fish/vendor_completions.d/fj.fish > $out
    '';
  home.sessionVariables.GHQ_ROOT = "$HOME/Developer";
}
