{ pkgs, ... }:
let
  swaymsg = "${pkgs.sway}/bin/swaymsg";
  pgrep = "${pkgs.procps}/bin/pgrep";
  jq = "${pkgs.jq}/bin/jq";
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
        # Only power back on if something is actually off: an unconditional
        # `output * power on` reconfigures the outputs on every resume, which
        # breaks active screen shares (portal-wlr dies with "session already
        # has a frame object", or the share only shows damaged regions).
        # (`.active` skips outputs kanshi disabled, e.g. eDP-1 when docked,
        # which also report power == false.)
        resumeCommand = "${swaymsg} -t get_outputs | ${jq} -e 'any(.[]; .active and .power == false)' >/dev/null && ${swaymsg} 'output * power on'";
      }
    ];
    events.before-sleep = "${pkgs.swaylock}/bin/swaylock -f";
  };
}
