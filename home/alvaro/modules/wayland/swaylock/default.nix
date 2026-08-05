{ ... }:
{
  programs.swaylock = {
    enable = true;
    settings = { };
  };
  xdg.configFile."swaylock/config".source = ./config;
  # Lid-close suspend is handled by logind (nixos/hosts/framework/hw.nix)
  # so the machine also sleeps outside a sway session and re-suspends after
  # spurious wakes; swayidle's before-sleep locks the screen first.
  xdg.configFile."sway/config.d/3_lock".text = ''
    bindsym --locked Mod1+Ctrl+q exec systemctl suspend
  '';
}
