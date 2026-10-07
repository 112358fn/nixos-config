{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.chromium = {
    enable = true;
    package = pkgs.unstable.ungoogled-chromium;
  };
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox.override {
      nativeMessagingHosts = [ pkgs.unstable.passff-host ];
    };
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
  # HM always links native messaging hosts into ~/.mozilla; the wrapper handles them instead
  mozilla.firefoxNativeMessagingHosts = lib.mkForce [ ];
  # Same pattern as terminal.nix: mod+1 goes to workspace 1 and starts
  # firefox there if no firefox window exists yet.
  xdg.configFile."sway/config.d/4_browser".text = ''
    assign [app_id="^firefox$"] workspace number 1
    bindsym $mod+1 exec 'swaymsg "workspace number 1"; swaymsg "[app_id=firefox] nop" || firefox'
  '';
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
