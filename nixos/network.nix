{config, ...}: {
  sops.secrets = {
    "networks/home/ssid" = {};
    "networks/home/password" = {};
  };

  networking.wireless.iwd.enable = true;

  networking.wireless.networks = {
    ssid = {
      psk = psk;
    };
  };
}
