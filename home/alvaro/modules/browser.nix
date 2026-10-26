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
      nativeMessagingHosts = with pkgs.unstable; [
        passff-host
        firefoxpwa
        tridactyl-native
      ];
    };
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    profiles.default = {
      id = 0;
      path = "0f2k6b72.default";
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userChrome = ''
        /* Remove the top-edge hover target so the toolbars never slide down on
           mouse-over. The toolbox itself stays off-screen via Firefox's own
           margin trick, which keeps the URL bar focusable: Ctrl+L still works. */
        :root[inFullscreen] #fullscr-toggler {
          display: none !important;
        }
      '';
      search = {
        force = true;
        default = "google";
        order = [
          "google"
          "nixos-packages"
          "home-manager"
        ];
        engines = {
          nixos-packages = {
            name = "NixOS Packages";
            urls = [ { template = "https://search.nixos.org/packages?channel=26.05&query={searchTerms}"; } ];
            definedAliases = [ "@nix" ];
          };
          home-manager = {
            name = "home-manager";
            urls = [
              {
                template = "https://home-manager-options.extranix.com/?release=release-26.05&query={searchTerms}";
              }
            ];
            definedAliases = [ "@hm" ];
          };
        };
      };
    };
    policies.ExtensionSettings = {
      "passff@invicem.pro" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/passff/latest.xpi";
      };
      "firefoxpwa@filips.si" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/pwas-for-firefox/latest.xpi";
      };
      "tridactyl.vim@cmcaine.co.uk" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/tridactyl-vim/latest.xpi";
      };
      "uBlock0@raymondhill.net" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      };
      "@testpilot-containers" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
      };
    };
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
    pkgs.unstable.firefoxpwa
    (pkgs.writeShellScriptBin "browser-dispatch" ''
      case "$1" in
        *meet.google.com*)
          exec ${pkgs.unstable.ungoogled-chromium}/bin/chromium --app="$1"
          ;;
        *)
          exec ${config.programs.firefox.finalPackage}/bin/firefox "$1"
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
