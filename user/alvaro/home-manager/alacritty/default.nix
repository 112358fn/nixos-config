{ ... }: {
  xdg.configFile."alacritty".source = ./alacritty;
  programs.alacritty.enable = true;
  programs.tmux = {
    enable = true;
  };
}
