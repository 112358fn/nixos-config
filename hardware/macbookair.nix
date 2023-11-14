{ config, lib, pkgs, modulesPath, ... }: {
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "wl" "acpi_call"];
  boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta acpi_call ];
  boot.kernelParams = [
    "hid_apple.iso_layout=0"
    "hid_apple.swap_opt_cmd=0"
    "i915.enable_rc6=7"
    "i915"
  ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/7fbdb398-f0d1-4877-979c-1be89795413e";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/683A-861C";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/9bdaf0d5-1944-4a24-aa79-040bd78f5c5d"; }];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.bluetooth = {
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
  hardware.pulseaudio.enable = true;
  hardware.facetimehd.enable = true;
  sound.enable = true;
  services.mbpfan.enable = lib.mkDefault true;
  services.fstrim.enable = lib.mkDefault true;
  services.tlp.enable = lib.mkDefault true;
}
