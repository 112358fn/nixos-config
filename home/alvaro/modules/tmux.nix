{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    shell = "${pkgs.fish}/bin/fish";
    escapeTime = 10;
    focusEvents = true;
    mouse = true;
    keyMode = "vi";
    prefix = "C-s";
    plugins = [
      pkgs.tmuxPlugins.catppuccin
      pkgs.tmuxPlugins.vim-tmux-navigator
      {
        plugin = pkgs.tmuxPlugins.resurrect;
        # one save dir per server socket (tmux -L work / tmux -L personal),
        extraConfig = ''
          run-shell 'tmux set -g @resurrect-dir "$HOME/.local/share/tmux/resurrect/$(basename "#{socket_path}")"'
        '';
      }
    ];
    extraConfig = ''
      set -g @catppuccin_flavor 'mocha'
      set -g status-left ""
      set -g status-right '#{?client_prefix,#[fg=#{@thm_peach}]● ,}#[fg=#{@thm_crust},bg=#{@thm_maroon}] server: #{b:socket_path} #[fg=#{@thm_crust},bg=#{@thm_teal}] session: #S '
      set -g status-position top

      set -sa terminal-features ",foot*:RGB:sixel:extkeys"
      set -s extended-keys on
      set -s extended-keys-format csi-u

      set -g allow-passthrough on
      set -g visual-activity off
      set-option -g focus-events on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      set -g renumber-windows on
      set -g detach-on-destroy off

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # vim-tmux-navigator takes C-l; prefix C-l clears the screen
      bind C-l send-keys 'C-l'

      bind a display-popup -h 30 -w 100 -E "workmux dashboard"
    '';
  };

  home.packages = with pkgs; [
    llm-agents.workmux
  ];

  xdg.configFile."workmux/config.yaml".text = ''
    nerdfont: true
    mode: session
    default_session: main
  '';
}
