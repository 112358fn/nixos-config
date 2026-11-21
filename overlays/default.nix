# This file defines overlays
{ inputs, ... }:
{
  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };

  # llm-agents' own package set (built against its pinned nixpkgs, so the
  # store paths match cache.numtide.com), exposed as 'pkgs.llm-agents'
  llm-agents = final: _prev: {
    llm-agents = inputs.llm-agents.packages.${final.stdenv.hostPlatform.system};
  };

  # xdg-desktop-portal-wlr from l4l's v0.8-screencopy-trigger branch (based on
  # 0.8.4): the portal drives the PipeWire graph itself and triggers a capture
  # after each frame. Testing it against screen shares on sway that show only
  # damaged regions and crash with "session already has a frame object".
  xdg-desktop-portal-wlr = final: prev: {
    xdg-desktop-portal-wlr = prev.xdg-desktop-portal-wlr.overrideAttrs (_old: {
      version = "0.9.0";
      src = final.fetchFromGitHub {
        owner = "emersion";
        repo = "xdg-desktop-portal-wlr";
        rev = "8388b8a6214470462146840e92909aff5983eeac";
        hash = "sha256-ZfqItKmh/z1LK8XdfdQxxV4FsKdyGGFZb33iuCLogPE=";
      };
    });
  };
}
