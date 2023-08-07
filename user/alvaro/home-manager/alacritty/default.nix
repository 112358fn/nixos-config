{ ... }: {
  xdg.configFile."alacritty".source = ./alacritty;
  programs.alacritty.enable = true;
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # --> Catppuccin (Mocha)
      thm_bg="#1e1e2e"
      thm_fg="#cdd6f4"
      thm_cyan="#89dceb"
      thm_black="#181825"
      thm_gray="#313244"
      thm_magenta="#cba6f7"
      thm_pink="#f5c2e7"
      thm_red="#f38ba8"
      thm_green="#a6e3a1"
      thm_yellow="#f9e2af"
      thm_blue="#89b4fa"
      thm_orange="#fab387"
      thm_black4="#585b70"
      
      local show_directory
      readonly show_directory="#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]$r_left_separator#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics]$directory_icon #[fg=$thm_fg,bg=$thm_gray] #{b:pane_current_path} "

      local show_window
      readonly show_window="#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]$r_left_separator#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics]$window_icon #[fg=$thm_fg,bg=$thm_gray] #W "

      local show_session
      readonly show_session="#[fg=$thm_green]#[bg=$thm_gray]#{?client_prefix,#[fg=$thm_red],#[fg=$thm_green]}$r_left_separator#{?client_prefix,#[bg=$thm_red],#[bg=$thm_green]}#[fg=$thm_bg]$session_icon #[fg=$thm_fg,bg=$thm_gray] #S "

      local show_directory_in_window_status
      readonly show_directory_in_window_status="#[fg=$thm_bg,bg=$thm_blue] #I #[fg=$thm_fg,bg=$thm_gray] #{b:pane_current_path} "

      local show_directory_in_window_status_current
      readonly show_directory_in_window_status_current="#[fg=$thm_bg,bg=$thm_orange] #I #[fg=$thm_fg,bg=$thm_bg] #{b:pane_current_path} "

      local show_window_in_window_status
      readonly show_window_in_window_status="#[fg=$thm_fg,bg=$thm_bg] #W #[fg=$thm_bg,bg=$thm_blue] #I#[fg=$thm_blue,bg=$thm_bg]$l_right_separator "

      local show_window_in_window_status_current
      readonly show_window_in_window_status_current="#[fg=$thm_fg,bg=$thm_gray] #W #[fg=$thm_bg,bg=$thm_orange] #I#[fg=$thm_orange,bg=$thm_bg,nobold,nounderscore,noitalics]$l_right_separator "

      local show_user
      readonly show_user="#[fg=$thm_cyan,bg=$thm_gray,nobold,nounderscore,noitalics]$r_left_separator#[fg=$thm_bg,bg=$thm_cyan,nobold,nounderscore,noitalics]$user_icon #[fg=$thm_fg,bg=$thm_gray] #(whoami) "

      local show_host
      readonly show_host="#[fg=$thm_magenta,bg=$thm_gray,nobold,nounderscore,noitalics]$r_left_separator#[fg=$thm_bg,bg=$thm_magenta,nobold,nounderscore,noitalics]$host_icon #[fg=$thm_fg,bg=$thm_gray] #H "

      local show_date_time
      readonly show_date_time="#[fg=$thm_blue,bg=$thm_gray,nobold,nounderscore,noitalics]$r_left_separator#[fg=$thm_bg,bg=$thm_blue,nobold,nounderscore,noitalics]$datetime_icon #[fg=$thm_fg,bg=$thm_gray] $date_time "
    '';
  };
}
