{ pkgs, ... }: {
  imports = [ 
    ./network.nix
    ./godns.nix
    ./bind
    ];
  system.stateVersion = "23.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "consoleblank=120" ];
  };

  environment.systemPackages = [ pkgs.git ];

  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
    };
  };

  time.timeZone = "Europe/Stockholm";

}
