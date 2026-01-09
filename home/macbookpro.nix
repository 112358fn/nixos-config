{ ... }:
{
  home = {
    username = "AALONSO";
    homeDirectory = "/Users/AALONSO";
    stateVersion = "25.05";
  };
  imports = [
    ./base.nix
    ./packages/nvim.nix
    ./packages/shell_tools.nix
    ./packages/gnupg/macos.nix
    ./packages/ssh
    ./packages/macos
    ./packages/gui.nix
    ./packages/k8s_tools.nix
  ];
}
