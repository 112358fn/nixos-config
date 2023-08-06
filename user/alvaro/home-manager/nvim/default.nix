{ ... }: {
  xdg.configFile."nvim".source = ./nvim;
  home.sessionVariables.EDITOR = "nvim";
}
