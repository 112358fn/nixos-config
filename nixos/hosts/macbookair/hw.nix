{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/7fbdb398-f0d1-4877-979c-1be89795413e";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/683A-861C";
      fsType = "vfat";
    };
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/9bdaf0d5-1944-4a24-aa79-040bd78f5c5d"; } ];

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-vaapi-driver
        libva-vdpau-driver
        libvdpau-va-gl
        vpl-gpu-rt
      ];
    };
    bluetooth = {
      enable = true;
      settings = {
        General = {
          ControllerMode = "dual";
          FastConnectable = "true";
        };
        Policy = {
          AutoEnable = "true";
        };
      };
    };
    facetimehd.enable = true;
  };

  services = {
    mbpfan.enable = lib.mkDefault true;
    fstrim.enable = lib.mkDefault true;
    tlp.enable = lib.mkDefault true;
    libinput.touchpad.naturalScrolling = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
