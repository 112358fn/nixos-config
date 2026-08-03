{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    shell = "${pkgs.fish}/bin/fish";
    escapeTime = 10; # near-instant Esc in nvim (default 500ms is painful)
    focusEvents = true; # nvim autoread/gitsigns react when you switch panes
    mouse = true; # optional, but cheap QoL
    baseIndex = 1; # so Alt-1 is the first window, not the second
    plugins = [ pkgs.tmuxPlugins.vim-tmux-navigator ];
    extraConfig = ''
      set -sa terminal-features ",foot*:RGB"

      set -g renumber-windows on # keep indices contiguous so Alt-N stays predictable

      bind -n C-t new-window -c "#{pane_current_path}" # prefix-less, like a browser tab

      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9
    '';
  };
}
