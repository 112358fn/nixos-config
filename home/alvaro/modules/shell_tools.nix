{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    pass
    eza
    ripgrep
    fzf
    gnused
    gnumake
    taskwarrior3
    ghq
    git
    fswatch
    unstable.rclone
    duckdb
    powertop
    jq
    yq-go
    uv
    llm-agents.claude-code
    llm-agents.claude-agent-acp
    llm-agents.gemini-cli
    dig
    go
    clang
    usbutils
  ];
  imports = [ inputs.direnv-instant.homeModules.direnv-instant ];
  xdg.enable = true;
  programs = {
    bash.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_autosuggestion_enabled 0
      '';
      functions = {
        c = {
          wraps = "cd";
          body = ''
            if test (count $argv) = 0
              if set -f root (git rev-parse --show-toplevel 2>/dev/null)
                cd $root
              else
                cd
              end
            else
              cd $argv[1]
            end
          '';
        };
        repo = {
          wraps = "ghq";
          body = ''
            if test (count $argv) = 0
              if set -f proj (ghq list --exact | fzf)
                cd (ghq list --exact --full-path $proj)
              end
            else
              ghq $argv
            end
          '';
        };
        getcerts = {
          argumentNames = "host";
          body = ''
            echo \
              | openssl s_client -connect $host:443 -showcerts 2>/dev/null \
              | openssl x509 -noout -subject -ext subjectAltName -issuer -dates -serial
          '';
        };
        o.body = ''
          set -l RELOAD 'reload:rg --column --color=always --smart-case {q} || :'
          set -l OPENER 'if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
                  nvim {1} +{2}     # No selection. Open the current line in nvim.
                else
                  nvim +cw -q {+f}  # Build quickfix list for the selected items.
                fi'

          fzf --disabled --ansi --multi \
            --bind "start:$RELOAD" --bind "change:$RELOAD" \
            --bind "enter:become:$OPENER" \
            --bind "ctrl-o:execute:$OPENER" \
            --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
            --delimiter : \
            --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
            --preview-window '~4,+{2}+4/3,<80(up)' \
            --query "$argv"
        '';
      };
    };
    starship = {
      enable = true;
      enableBashIntegration = false;
      settings = fromTOML (builtins.readFile ./starship.toml);
    };
    direnv-instant = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
    };
    direnv = {
      nix-direnv.enable = true;
      config.global.hide_env_diff = true;
    };
    bat = {
      enable = true;
      config = {
        style = "plain";
      };
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
    yazi = {
      enable = true;
      enableFishIntegration = true;
      shellWrapperName = "y";
    };
  };
}
