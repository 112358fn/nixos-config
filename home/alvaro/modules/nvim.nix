{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    sideloadInitLua = true;
    extraPackages = with pkgs; [
      tree-sitter
      nixfmt-rfc-style
      pyright
      ruff
      gopls
      yaml-language-server
      taplo
      typescript-language-server
      tex-fmt
      markdownlint-cli
      prettierd
      js-beautify
    ];
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
