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
    plugins = [ pkgs.tmuxPlugins.vim-tmux-navigator pkgs.tmuxPlugins.catppuccin ];
    extraConfig = ''
      set -g @catppuccin_flavor 'mocha'
      set -g @catppuccin_window_status_style "slanted"
      set -g @catppuccin_window_current_number_color "#{@thm_peach}"
      set -g @catppuccin_window_number_color "#{@thm_mauve}"
      set -g status-left ""
      set -g status-right '#[fg=#{@thm_crust},bg=#{@thm_teal}] session: #S '
      set -g status-right-length 100

      set -sa terminal-features ",foot*:RGB:sixel"

      set -g allow-passthrough on
      set -g visual-activity off
      set-option -g focus-events on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      set -g renumber-windows on # keep indices contiguous so Alt-N stays predictable

      bind -n C-t new-window

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

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

  home.packages = with pkgs; [
    llm-agents.workmux
  ];

  xdg.configFile."workmux/config.yaml".text = ''
    nerdfont: true
    mode: session
  '';
}
