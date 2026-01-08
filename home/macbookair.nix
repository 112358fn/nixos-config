{ ... }:
{
  home = {
    username = "alvaro";
    homeDirectory = "/home/alvaro";
    stateVersion = "25.05";
  };
  imports = [
    ./base.nix
    ./packages/nvim.nix
    ./packages/shell_tools.nix
    ./packages/gnupg/linux.nix
    ./packages/ssh
  ];
}
