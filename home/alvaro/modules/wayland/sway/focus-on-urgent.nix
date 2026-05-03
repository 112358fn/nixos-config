{ pkgs, ... }:
{
  systemd.user.services.focus-on-urgent = {
    Unit = {
      Description = "Make sway focus on urgent windows";
      After = "graphical-session.target";
      ConditionEnvironment = "WAYLAND_DISPLAY";
      PartOf = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Restart = "always";
      Type = "simple";
      ExecStart = "${pkgs.writeShellScript "focus-on-urgent" ''
        #!/run/current-system/sw/bin/bash
        ${pkgs.sway}/bin/swaymsg -mt subscribe '["window"]' | \
        ${pkgs.jq}/bin/jq --unbuffered 'select(.change == "urgent").container.id'| \
        ${pkgs.findutils}/bin/xargs -I{} ${pkgs.sway}/bin/swaymsg '[con_id={}]' focus
      ''}";
    };
  };
}
