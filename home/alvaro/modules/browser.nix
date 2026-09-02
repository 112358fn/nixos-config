{ pkgs, config, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.unstable.ungoogled-chromium;
  };
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox;
    nativeMessagingHosts = [ pkgs.unstable.passff-host ];
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
  home.packages = [
    (pkgs.writeShellScriptBin "browser-dispatch" ''
      case "$1" in
        *meet.google.com*)
          exec ${pkgs.unstable.ungoogled-chromium}/bin/chromium --app="$1"
          ;;
        *)
          exec ${pkgs.firefox}/bin/firefox "$1"
          ;;
      esac
    '')
  ];
  xdg.desktopEntries.browser-dispatch = {
    name = "Browser Dispatcher";
    exec = "browser-dispatch %u";
    categories = [
      "Network"
      "WebBrowser"
    ];
    mimeType = [
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "text/html"
    ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "browser-dispatch.desktop";
      "x-scheme-handler/https" = "browser-dispatch.desktop";
      "text/html" = "browser-dispatch.desktop";
    };
  };
}
