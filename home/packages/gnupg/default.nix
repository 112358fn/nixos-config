{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gnupg
    pinentry_mac
  ];
  home.file = {
    ".gnupg/gpg.conf".source = ./gpg.conf;
    ".gnupg/gpg-agent.conf".source = ./gpg-agent.conf;
  };
}
