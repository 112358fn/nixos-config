{ config, lib, pkgs, modulesPath, ... }: {
  imports =
    [ 
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "i915"];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "i915.enable_guc=2"
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver 
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };
  services.thermald.enable = lib.mkDefault true;
  services.fstrim.enable = lib.mkDefault true;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/75ca3ec4-98e2-41f1-aa8a-854d1a2397ae";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" "discard" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4CED-4E37";
      fsType = "vfat";
    };

  fileSystems."/mnt/data" =
    { device = "/dev/disk/by-uuid/bf611155-d2d6-48b8-ade9-785c6baa78ef";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" "discard" ];
    };
    
  swapDevices =
    [ { device = "/dev/disk/by-uuid/9aba32b0-d3c0-468c-830a-e1851c865034"; }
    ];


  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
