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

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "thunderbolt"
      "usb_storage"
      "sd_mod"
    ];
    initrd.kernelModules = [
      "dm-snapshot"
      "cryptd"
    ];
    initrd.luks.devices."cryptroot".device = "/dev/disk/by-label/nixos";
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    # Silent boot
    loader.timeout = 0;
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
    # Splash screen with password
    plymouth.enable = true;
    initrd.systemd.enable = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/14E4-F166";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics.enable = true;
    framework.amd-7040.preventWakeOnAC = true;
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
  };
  services = {
    fprintd.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandleHibernateKey = "ignore";
      HandleRebootKey = "ignore";
      HandleSuspendKey = "ignore";
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
    };
  };
}
