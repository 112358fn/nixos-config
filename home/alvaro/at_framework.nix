{ inputs, ... }:
{
  imports = [
    ./modules/gnupg/linux.nix
    ./modules/ssh
    ./modules/wayland
    ./modules/browser.nix
    ./modules/git.nix
    ./modules/messaging.nix
    ./modules/notes.nix
    ./modules/nvim.nix
    ./modules/shell_tools.nix
    ./modules/yubikey.nix
  ];
  home.stateVersion = "25.05";

  home.homeDirectory = "/home/alvaro";
  programs.home-manager.enable = true;

  nixpkgs = {
    overlays = [
      inputs.self.overlays.unstable-packages
      inputs.llm-agents.overlays.default
    ];
    config.allowUnfree = true;
  };
}
