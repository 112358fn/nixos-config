{...}: {
  programs.git = {
    enable = true;
    userName = "Alvaro Alonso";
    userEmail = "112358.fn@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      push.default = "current";
    };
    #signing = true;
  };
}
