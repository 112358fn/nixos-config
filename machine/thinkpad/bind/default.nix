{ ... }: {
  services.bind = {
    enable = true;
    zones."alonsobivou.com" = {
      master = true;
      file = ./db.alonsobivou.com;
    };
    forward = "only";
    extraOptions = ''
    	recursion yes;
	    allow-recursion { any; };
	    allow-query-cache { any; };
    '';
  };
}
