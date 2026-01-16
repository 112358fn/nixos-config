{
  inputs,
  config,
  pkgs,
  ...
}:
{
  programs = {
    home-manager.enable = true;
    bash.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_autosuggestion_enabled 0
      '';
      shellAliases = {
        k = "kubectl";
      };
    };
  };
  xdg.enable = true;
  home = {
    sessionVariables = {
      GHQ_ROOT = "$HOME/Developer";
      ZK_NOTEBOOK_DIR = "$HOME/Notes";
      PYENV_ROOT = "$HOME/.pyenv";
      GOPATH = "$HOME/go";
    };
    sessionPath = [
      "$HOME/.local/bin"
      "/opt/homebrew/bin"
      "/usr/local/bin"
      "/opt/homebrew/opt/coreutils/libexec/gnubin/"
      "$PYENV_ROOT/bin"
      "$GOPATH/bin"
      "$HOME/.cargo/bin"
    ];
    shell.enableFishIntegration = true;
  };
  nixpkgs = {
    overlays = [
      inputs.self.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };
}
