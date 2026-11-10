{ inputs, pkgs, ... }:
let
  modifier = "Mod4";
in
{
  imports = [
    ./kanshi
    ./gtk.nix
    ./kdeconnect.nix
    ./webcam.nix
    ./terminal.nix
    ./xdg.nix
    ./sway
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
    };
  };
  wayland.windowManager.sway.config = {
    floating.criteria = [
      { app_id = "dev.noctalia.Noctalia"; }
    ];

    keybindings = {
      "${modifier}+d" = "exec noctalia msg panel-toggle launcher";
      "${modifier}+s" = "exec noctalia msg panel-toggle control-center";
      "${modifier}+comma" = "exec noctalia msg settings-toggle";
      "${modifier}+Tab" = "exec noctalia msg window-switcher hold";
      "XF86PowerOff" = "exec noctalia msg panel-toggle session";
      "Mod1+Ctrl+q" = "exec noctalia msg session lock-and-suspend";
      "XF86AudioRaiseVolume" = "exec noctalia msg volume-up";
      "XF86AudioLowerVolume" = "exec noctalia msg volume-down";
      "XF86AudioMute" = "exec noctalia msg volume-mute";
      "XF86MonBrightnessUp" = "exec noctalia msg brightness-up";
      "XF86MonBrightnessDown" = "exec noctalia msg brightness-down";
      "XF86AudioPlay" = "exec noctalia msg media toggle";
      "XF86AudioNext" = "exec noctalia msg media next";
      "XF86AudioPrev" = "exec noctalia msg media previous";
      "Print" = "exec noctalia msg screenshot-region";
      "$mod+b" = "exec noctalia msg bar-toggle";
    };

    startup = [
      {
        command = "noctalia";
        always = true;
      }
      # https://todo.sr.ht/~emersion/kanshi/35
      {
        command = "kanshictl reload";
        always = true;
      }
    ];
  };
}
