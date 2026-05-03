{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.unstable.ungoogled-chromium;
  };
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox;
    nativeMessagingHosts = [ pkgs.unstable.passff-host ];
  };
}
