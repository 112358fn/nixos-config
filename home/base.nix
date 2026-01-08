{
  inputs,
  config,
  pkgs,
  ...
}:
{
  programs.home-manager.enable = true;
  nixpkgs = {
    overlays = [
      inputs.self.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };
}
