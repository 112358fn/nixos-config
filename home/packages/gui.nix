{
  config,
  pkgs,
  unstable_pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    obsidian
    mattermost-desktop
  ];
}
