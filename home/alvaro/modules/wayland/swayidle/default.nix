{ pkgs, ... }:
let
  swaymsg = "${pkgs.sway}/bin/swaymsg";
  pgrep = "${pkgs.procps}/bin/pgrep";
in
{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        # Only power off the display while the screen is locked; when
        # unlocked the timeout fires and does nothing, so reading for a
        # long time never blanks the screen.
        #
        # The Nix swaylock binary is a wrapper that execs .swaylock-wrapped,
        # and the kernel truncates comm to 15 chars, so the running process
        # is named ".swaylock-wrapp". Match that as well as plain "swaylock".
        timeout = 15;
        command = "${pgrep} -x '\\.?swaylock.*' && ${swaymsg} 'output * power off'";
        resumeCommand = "${swaymsg} 'output * power on'";
      }
    ];
    events.before-sleep = "${pkgs.swaylock}/bin/swaylock -f";
  };
}
