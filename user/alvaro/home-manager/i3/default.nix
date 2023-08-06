{ pkgs, ... }: {
  xdg.configFile."i3/config".text = builtins.readFile ./config;
  xdg.configFile."i3status/config".text = builtins.readFile ./i3status;
  xdg.dataFile."i3lock/script.sh" = {
    executable = true;
    text = builtins.readFile ./i3lock.sh;
  };
  home.packages = with pkgs; [
    xss-lock
    i3lock-color
  ];
}
