{ config, ... }: {
  users.users = {
    user = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      # initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILp007s4hFGCvBDiBwDzY45KZfyjUEcE34nE5W2eYPGD nima.kalantar" ];
      extraGroups = [ "networkmanager" "wheel" "docker" ];
    };
  };
}