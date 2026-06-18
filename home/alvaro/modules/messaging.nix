{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unstable.mattermost-desktop
  ];
}
