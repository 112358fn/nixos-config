{pkgs, ...}: {
  environment.systemPackages = [pkgs.godns];
}