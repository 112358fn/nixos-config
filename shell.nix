{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    nixfmt-rfc-style
    markdownlint-cli
  ];
}
