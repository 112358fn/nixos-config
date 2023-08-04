{ config, pkgs, ... }:

{
  xdg = {
    enable = true;
    configFile."i3/config".text = builtins.readFile ./i3;
    configFile."nvim".source = ./nvim;
    #configFile."rofi/config.rasi".text = builtins.readFile ./rofi;
  };

  home = {
    stateVersion = "23.05";
    
    packages = with pkgs; [
     nix-output-monitor
     brave
     
     rofi
     
     bat
     fzf
     ripgrep
    ];

    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      EDITOR = "nvim";
    };
  };

  services = {
    gpg-agent = { 
      enable = true;
      enableSshSupport = true;
    };
  };

  programs = {
    home-manager.enable = true;
    password-store.enable = true;
    gpg = {
      enable = true;
      settings = {
        personal-cipher-preferences = "AES256 AES192 AES";
	personal-digest-preferences = "SHA512 SHA384 SHA256";
	personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
	default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
	cert-digest-algo = "SHA512";
	s2k-digest-algo = "SHA512";
	s2k-cipher-algo = "AES256";
	charset = "utf-8";
	fixed-list-mode = true;
	no-comments = true;
	no-emit-version = true;
	no-greeting = true;
	keyid-format = "0xlong";
	list-options = "show-uid-validity";
	verify-options = "show-uid-validity";
	with-fingerprint = true;
	require-cross-certification = true;
	no-symkey-cache = true;
	use-agent = true;
	throw-keyids = true;
      };
    };
    git = {
      enable = true;
      userName = "Alvaro Alonso";
      userEmail = "112358.fn@gmail.com";
      extraConfig = {
	init.defaultBranch = "main";
	push.default = "current";
      };
      #signing = true;
    };  
    alacritty = {
      enable = true;
      settings = {
	font = {
	  size = 12;
	  draw_bold_text_with_bright_colors = true;
	};
	scrolling.multiplier = 5;
	selection.save_to_clipboard = true;
      };
    };
    zsh = {
      enable = true;
      oh-my-zsh = {
	enable = true;
	theme = "robbyrussell";
	plugins = ["git"];
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
