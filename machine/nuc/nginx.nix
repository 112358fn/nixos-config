{ config, ... }: {
  services.nginx = {
    enable = true;

  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "112358.fn@gmail.com";
  };
}
