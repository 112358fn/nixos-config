{ pkgs, ... }:
let
  modifier = "Mod4";
in
{
  imports = [ ./focus-on-urgent.nix ];

  home.packages = with pkgs; [
    wl-clipboard
  ];

  wayland.windowManager.sway = {
    enable = true;
    # sway itself comes from the NixOS programs.sway module; validating the
    # config needs a package, so the build-time check goes with it.
    package = null;
    checkConfig = false;
    extraConfigEarly = ''
      set $mod ${modifier}
    '';
    systemd.variables = [ "--all" ];
    xwayland = true;

    config = {
      modifier = modifier;
      workspaceAutoBackAndForth = true;

      bars = [ ];

      focus.wrapping = "yes";

      fonts = {
        names = [ "monospace" ];
        size = 8.0;
      };

      # xcursor_theme comes from home.pointerCursor (wayland/gtk.nix)
      seat."*".hide_cursor = "when-typing enable";

      window = {
        titlebar = false;
        border = 3;
        hideEdgeBorders = "smart";
        commands = [
          {
            command = "border none, focus";
            criteria.app_id = "gcr-prompter";
          }
          {
            command = "focus, move position center";
            criteria.app_id = "org.pulseaudio.pavucontrol";
          }
          {
            command = "focus, move position center";
            criteria.app_id = ".blueman-manager-wrapped";
          }
        ];
      };

      # Catppuccin Macchiato: https://github.com/catppuccin/i3
      colors = {
        background = "#24273a";
        focused = {
          border = "#b7bdf8";
          background = "#24273a";
          text = "#cad3f5";
          indicator = "#f4dbd6";
          childBorder = "#b7bdf8";
        };
        focusedInactive = {
          border = "#6e738d";
          background = "#24273a";
          text = "#cad3f5";
          indicator = "#f4dbd6";
          childBorder = "#6e738d";
        };
        unfocused = {
          border = "#6e738d";
          background = "#24273a";
          text = "#cad3f5";
          indicator = "#f4dbd6";
          childBorder = "#6e738d";
        };
        urgent = {
          border = "#f5a97f";
          background = "#24273a";
          text = "#f5a97f";
          indicator = "#6e738d";
          childBorder = "#f5a97f";
        };
        placeholder = {
          border = "#6e738d";
          background = "#24273a";
          text = "#cad3f5";
          indicator = "#6e738d";
          childBorder = "#6e738d";
        };
      };

      floating.criteria = [
        { app_id = ".blueman-manager-wrapped"; }
        { app_id = "org.gnome.NautilusPreviewer"; }
        { app_id = "org.pulseaudio.pavucontrol"; }
        { app_id = "wdisplays"; }
        { app_id = "org.kde.easyeffects"; }
      ];

      input = {
        "type:touchpad" = {
          accel_profile = "adaptive";
          dwt = "enabled";
          natural_scroll = "enabled";
          pointer_accel = "0.0";
          scroll_factor = "1.0";
          tap = "enabled";
          tap_button_map = "lrm";
        };
        "type:pointer" = {
          accel_profile = "adaptive";
          dwt = "enabled";
          natural_scroll = "enabled";
          pointer_accel = "-0.5";
          scroll_factor = "1.0";
        };
        "type:keyboard" = {
          repeat_rate = "0";
          # ä/å/ö on AltGr+q/w/p (Shift for the capitals)
          xkb_layout = "us";
          xkb_variant = "altgr-intl";
        };
      };

      keybindings = {
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";
        "${modifier}+o" = "workspace back_and_forth";
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "${modifier}+Shift+0" = "move container to workspace number 10";
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+a" = "focus parent";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+q" = "kill";
        "${modifier}+Shift+e" =
          "exec swaynag -t warning -m 'Do you really want to exit sway?' -b 'Yes, exit sway' 'swaymsg exit'";

        "${modifier}+e" = "layout toggle split";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+f" = "fullscreen toggle";

        "${modifier}+v" = "split toggle";
        "${modifier}+x" = "split none";

        "${modifier}+r" = "mode resize";
      };
    };
  };

}
