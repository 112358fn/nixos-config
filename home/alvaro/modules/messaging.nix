{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mattermost-desktop
    unstable.signal-desktop
  ];
}
