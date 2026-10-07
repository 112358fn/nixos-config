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
    ./modules/tmux.nix
    ./modules/ebooks.nix
    ./modules/claude
  ];
  home.stateVersion = "25.05";

  home.homeDirectory = "/home/alvaro";
  programs.home-manager.enable = true;

  nixpkgs = {
    overlays = [
      inputs.self.overlays.unstable-packages
      inputs.self.overlays.llm-agents
      inputs.self.overlays.xdg-desktop-portal-wlr
    ];
    config.allowUnfree = true;
  };
}
