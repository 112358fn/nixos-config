{ ... }:
{
  services.syncthing = {
    enable = true;

    # Devices and folders are managed in the GUI; don't let the init service
    # delete them because they aren't declared here.
    overrideDevices = false;
    overrideFolders = false;

    settings.options.localAnnounceEnabled = true;
  };
}
