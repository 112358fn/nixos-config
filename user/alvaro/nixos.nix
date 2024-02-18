{ pkgs, ... }: {
  users.users.alvaro = {
    isNormalUser = true;
    home = "/home/alvaro";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDfDofWEXwuMRtaXI4Vk6/hla4w53/gMbvknPc7CSaFC3sv4gqBogreWJyJ62ZpwnClxhmM9k4J2gdkZlV56m3gbbKaLaLCSOjPoLYMy+2ruiyRrfhSHFJFFJJCBKgPN9GSE3xi53j4WFPCOZ6prA6EzRzYAWV0sZsoIHo9NEI6kdkWa8d7lH43zPcL9+qIA9hwPs2cZ/1YMXFSGeLpJPpNv0F7JGgqLtWY1kN7dd1jMPAwM1hFCi9SQj0SNurntT8WNlsZoJks+c3OvFzvgfFgHSOOjSacjFNRJE1qi8BWjK++cA2940hj1the3CKFA8c8PVMM6zWOHIR/Y6W3V0YFQj3/SIldFFLrr4OffOHTNMZsrRaVK1zWpUPRGYNNW4AUBh37eUvUkkSv8BRwU4snZzBT3FVLJZMpVkWUOjPHmFeoS9DQ9CrI1uaArYMrj/i+O2c9ntZWyZ97hVHWx8n3OkwkOfC2UeSNOuW2RIbODGH7vPZnHJhrYxMDynwh3dIVkdwdDbxIbUCl+s9Fu9fofKf5FeAYkWpY1cBQpKOh2U5hR/42O0i76RlVAsom361NfZ+Sx25RkHQ5p6yKJ4m8zYypmwf8WdsnIXd8xJxxd8j4we4YsCR2AbCY/UVx+S2/L6BmidqqbHF11UZU2azD5VOOiazLNhyCrUsRk9LYkw== cardno:23_869_830"
    ];

    packages = with pkgs; [
      git
      ghq
      zk
      pass
      helix
      starship
      bat
      eza
      fzf
      ripgrep
      yadm
      gnupg
    ];
  };

  programs = {
    fish.enable = true;
    direnv.enable = true;
  };

  fonts.packages= with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "FiraCode" "DroidSansMono" ]; })
    lato
  ];
}
