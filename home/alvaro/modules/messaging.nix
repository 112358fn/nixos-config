{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unstable.mattermost-desktop
    unstable.signal-desktop
  ];
}
