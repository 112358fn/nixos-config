{ pkgs, ... }:
{
  home.packages = with pkgs; [
    yubikey-manager
    pam_u2f # provides pamu2fcfg to enroll the key
  ];
}
