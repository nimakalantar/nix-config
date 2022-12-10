# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  common = import ./common.nix;
  nix = import ./nix.nix;
  docker = import ./docker.nix;
  locale = import ./locale.nix;
  tailscale = import ./tailscale.nix;
}
