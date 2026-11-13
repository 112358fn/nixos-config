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
      version = "0.8.4-screencopy-trigger";
      src = final.fetchFromGitHub {
        owner = "l4l";
        repo = "xdg-desktop-portal-wlr";
        rev = "960e9305471521a6bcc46ab8b60c01920487e061";
        hash = "sha256-8qh1nrirlHXObkKLxRaDOxDgT8DoBVpjjy/mW2tZRw0=";
      };
    });
  };
}
