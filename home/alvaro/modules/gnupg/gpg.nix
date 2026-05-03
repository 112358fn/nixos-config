{pkgs, ...}:
{
  programs.gpg = {
    enable = true;
    settings = {
      charset = "utf-8";
      keyid-format = "0xlong";
      cert-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      s2k-digest-algo = "SHA512";
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      no-comments = true;
      no-emit-version = true;
      no-greeting = true;
      no-symkey-cache = true;
      require-cross-certification = true;
      throw-keyids = true;
      use-agent = true;
      with-fingerprint = true;
    };
  };
}
