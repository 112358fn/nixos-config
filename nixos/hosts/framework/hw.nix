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

  # This board only supports s2idle, which drains battery and can wake
  # spuriously in a bag; after 2h asleep on battery, wake and hibernate to
  # swap (inside LUKS) instead. If the image doesn't fit in the 8G swap,
  # systemd falls back to staying suspended.
  boot.resumeDevice = "/dev/disk/by-label/swap";
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
    # Don't let USB (xHCI) or Thunderbolt devices wake the machine from
    # s2idle — a nudged mouse in a bag would otherwise wake it once per
    # logind holdoff cycle. Lid and power button are ACPI/EC and still wake.
    udev.extraRules = ''
      ACTION=="add|change", SUBSYSTEM=="pci", DRIVER=="xhci_hcd", ATTR{power/wakeup}="disabled"
      ACTION=="add|change", SUBSYSTEM=="pci", DRIVER=="thunderbolt", ATTR{power/wakeup}="disabled"
    '';
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
      # Lid must be handled by logind, not a sway binding: logind re-suspends
      # when the lid is still closed after a spurious s2idle wake (a sway
      # bindswitch only fires on the close edge, so the laptop stayed awake
      # in the backpack). Screen locking happens via swayidle's before-sleep.
      HandleLidSwitch = "suspend-then-hibernate";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked = "ignore";
    };
  };
}
