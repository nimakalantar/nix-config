{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ tailscale ];

  # Enable the tailscale service
  services.tailscale.enable = true;

  networking.firewall = {
    # Enable the firewall
    enable = true;

    # Always allow traffic from your Tailscale network
    trustedInterfaces = [ "tailscale0" ];

    # Allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}
