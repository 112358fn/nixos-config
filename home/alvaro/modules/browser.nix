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
    profiles.personal = {
      id = 0;
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "sidebar.animation.enabled" = false;
        "sidebar.visibility" = "hide-sidebar";
        "browser.tabs.closeWindowWithLastTab" = false;
      };
      userChrome = ''
        #fullscr-toggler { display:none !important; }
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
    profiles.work = {
      id = 1;
      settings = config.programs.firefox.profiles.personal.settings;
      userChrome = config.programs.firefox.profiles.personal.userChrome;
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
  # We are using the pkg override.nativeMessaginHost instead
  mozilla.firefoxNativeMessagingHosts = lib.mkForce [ ];
  home.packages = [
    pkgs.unstable.firefoxpwa
  ];
}
