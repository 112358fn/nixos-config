{ ... }: {
  programs.firefox = {
    enable = true;
    profiles.personal = {
      isDefault = true;
      userChrome = with builtins;concatStringsSep "\n" (map (f: readFile ./chrome/includes/${f}) (attrNames (readDir ./chrome/includes)));
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
