{config, ...}: {
  networking.usePredictableInterfaceNames = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Direct ethernet connection
  networking.interfaces.enp112s0 = {
    useDHCP = false;
    ipv4.addresses = [
      {
        address = "10.0.0.1";
        prefixLength = 28;
      }
    ];
  };

  # networking.wireless.networks = {
  #   "" = {
  #     psk = "";
  #   };
  # };
}
