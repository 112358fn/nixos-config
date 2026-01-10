{
  inputs,
  config,
  pkgs,
  ...
}:
{
  programs = {
    home-manager.enable = true;
    bash.enable = true;
  };
  xdg.enable = true;
  nixpkgs = {
    overlays = [
      inputs.self.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };
}
