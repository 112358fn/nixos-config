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

  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.18.22") (
    lib.mkDefault pkgs.linuxPackages_6_18
  );
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
    initrd.luks.devices."cryptroot" = {
      device = "/dev/disk/by-label/nixos";
      # Try FIDO2 (YubiKey) first; without token-timeout it would wait
      # forever for the key instead of falling back to the passphrase
      # prompt. Enrolled via:
      #   systemd-cryptenroll --fido2-device=auto --fido2-with-client-pin=yes /dev/disk/by-label/nixos
      crypttabExtraOpts = [
        "fido2-device=auto"
        "token-timeout=10"
      ];
    };
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
      # Swapfile's first physical extent, for hibernation resume (see NOTE
      # at swapDevices).
      "resume_offset=77336576"
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

  # NOTE: changing `size` recreates the file, which invalidates the
  # resume_offset kernel param below — recompute it with
  # `filefrag -v /swap/swapfile` (first physical_offset) after a resize.
  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 32 * 1024;
    }
  ];

  # This board only supports s2idle, which drains battery and can wake
  # spuriously in a bag; after 2h asleep on battery, wake and hibernate to
  # the swapfile (inside LUKS) instead. If the image doesn't fit in the
  # 32G swapfile, systemd falls back to staying suspended.
  boot.resumeDevice = "/dev/disk/by-label/root";
  systemd.sleep.settings.Sleep.HibernateDelaySec = "2h";

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics.enable = true;
    framework.amd-7040.preventWakeOnAC = true;
    framework.laptop13.audioEnhancement.enable = true;
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
    # nixos-hardware enables fprintd by default; we use the YubiKey instead
    fprintd.enable = false;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    blueman.enable = true;
    logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandleHibernateKey = "ignore";
      HandleRebootKey = "ignore";
      HandleSuspendKey = "ignore";
      HandleLidSwitch = "suspend-then-hibernate";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked = "ignore";
    };
  };
}
