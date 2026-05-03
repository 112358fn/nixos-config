{ config, pkgs, ... }:
{
  home.file = {
    ".ssh/config".source = ./config;
    ".ssh/id_rsa_yubikey.pub".source = ./id_rsa_yubikey.pub;
  };
}
