{ config, ... }: {
  # Enable networking
  networking.networkmanager.enable = true;

  # networking.wireless.networks = {
  #   "" = {
  #     psk = "";
  #   };
  # };
}
