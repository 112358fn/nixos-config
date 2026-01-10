{ config, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [
      "kvm-intel"
      "wl"
      "acpi_call"
    ];
    extraModulePackages = with config.boot.kernelPackages; [
      broadcom_sta
      acpi_call
    ];
    kernelParams = [
      "hid_apple.iso_layout=0"
      "hid_apple.swap_opt_cmd=0"
      "i915.enable_rc6=7"
      "i915"
    ];
    blacklistedKernelModules = [
      "b43"
      "bcma"
    ];
  };
}
