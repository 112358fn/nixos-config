{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim-unwrapped
    tree-sitter
    nixfmt-rfc-style
    pyright
    ruff
    gopls
    yaml-language-server
    taplo
    typescript-language-server
    tex-fmt
    marksman
    markdownlint-cli
    prettierd
  ];
}
