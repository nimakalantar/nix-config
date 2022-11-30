{config, ...}: {
  # sops.secrets = {
  #   "users/root".neededForUsers = true;
  #   "users/user".neededForUsers = true;
  # };
  users.users = {
    root = {
      # passwordFile = config.sops.secrets.root.path;;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKqN6QIStiPMRYSQZsLVmhEtQrOToriIEPuPw+q1THp8"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILp007s4hFGCvBDiBwDzY45KZfyjUEcE34nE5W2eYPGD"
      ];
    };
    user = {
      # passwordFile = config.sops.secrets.user.path;;
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKqN6QIStiPMRYSQZsLVmhEtQrOToriIEPuPw+q1THp8"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILp007s4hFGCvBDiBwDzY45KZfyjUEcE34nE5W2eYPGD"
      ];
      extraGroups = ["wheel" "docker"];
    };
  };
}
