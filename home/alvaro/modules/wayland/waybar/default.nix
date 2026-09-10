{...}:{
    programs.waybar = {
      enable = true;
      systemd.enable = false;
      settings.mainBar = {
        ipc = true;
        mode = "hide";
        modifier-reset = "release";
        layer = "top";
        exclusive = false;
        start_hidden = true;
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ ];
        modules-right = [ "tray" "network" "battery" "clock" ];
        network = {
          format-wifi = "{signalStrength}% ";
          format-ethernet = "{ifname}";
          tooltip-format = "{ipaddr}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname} {essid}";
        };
        battery = {
          format = "{capacity}% {icon}  {power:.2}W";
          format-icons = [ "" "" "" "" "" ];
        };
        clock.format-alt = "{:%a, %d. %b  %H:%M}";
      };
      style = ./style.css;
    };
}
