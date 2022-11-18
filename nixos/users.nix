{ config, ... }: {
  users.users.user = {
    initialPassword = "TODO";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILp007s4hFGCvBDiBwDzY45KZfyjUEcE34nE5W2eYPGD nima.kalantar" ];
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
}
