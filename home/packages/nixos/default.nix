{ pkgs, ... }:
{
  imports = [
    ./wm.nix
  ];
  home.packages = with pkgs; [
    ghostty
    firefox
    unstable.ungoogled-chromium
    unstable.signal-desktop
  ];
}
