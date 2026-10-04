# This file defines overlays
{ inputs, ... }:
{
  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
      overlays = [ inputs.llm-agents.overlays.shared-nixpkgs ];
    };
  };

  # llm-agents packages built against nixpkgs-unstable, exposed as 'pkgs.llm-agents'
  llm-agents = final: _prev: {
    inherit (final.unstable) llm-agents;
  };
}
