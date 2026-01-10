{
  config,
  pkgs,
  unstable_pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ghostty
    obsidian
  ];
}
