{ pkgs, lib, ... }:
{
  imports = [
    ./base.nix
  ];

  users.users.alvaro.extraGroups = [
    "dialout"
    "i2c"
  ];

  programs.dconf.enable = true;
  # Needed to use uv
  # https://nix.dev/guides/faq#how-to-run-non-nix-executables
  programs.nix-ld.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    noto-fonts-color-emoji
    lato
    adwaita-fonts
  ];
  security = {
    polkit.enable = true;
    pam.services.swaylock = { };
  };
  services = {
    pcscd.enable = true;
    dbus.packages = [ pkgs.gcr ];

    # D-BUS service to manipulate storage devs
    udisks2.enable = true;
    # Tailscale
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
    upower.enable = true;
    # every HID device; FIDO tokens are already tagged by systemd's fido_id.
    udev.packages = [
      pkgs.yubikey-personalization
      # uaccess for the NuPhy Node 75 LP config interface (if03, 64-byte raw
      # vendor reports) so nuphio works. if00/if01 carry keystrokes and if02
      # mouse/media keys; they stay root-only. Must sort before
      # 73-seat-late.rules, which turns the uaccess tag into an ACL, so this
      # can't go in extraRules (99-local.rules).
      (pkgs.writeTextFile {
        name = "nuphy-udev-rules";
        destination = "/etc/udev/rules.d/70-nuphy.rules";
        text = ''
          SUBSYSTEM=="hidraw", ENV{ID_VENDOR_ID}=="19f5", ENV{ID_MODEL_ID}=="1030", ENV{ID_USB_INTERFACE_NUM}=="03", TAG+="uaccess"
        '';
      })
    ];
  };
}
