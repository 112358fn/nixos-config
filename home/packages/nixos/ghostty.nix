{ ... }:
{
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;
    settings = {
      theme = "Catppuccin Mocha";
      keybind = [
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
        "super+equal=increase_font_size:1"
        "super+minus=decrease_font_size:1"
      ];
      font-size = 15;
      font-family = "Hack Nerd Font Mono copy_to_clipboard";

      window-decoration = "none";

      cursor-invert-fg-bg = true;
      mouse-hide-while-typing = true;
    };
  };
}
