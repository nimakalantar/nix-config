{config, ...}: {
  users.users = {
    root = {
      # initialPassword = "TODO";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKqN6QIStiPMRYSQZsLVmhEtQrOToriIEPuPw+q1THp8 nima.kalantar@focusrite.com"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILp007s4hFGCvBDiBwDzY45KZfyjUEcE34nE5W2eYPGD nima.kalantar@focusrite.com"
      ];
    };
    user = {
      # initialPassword = "TODO";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKqN6QIStiPMRYSQZsLVmhEtQrOToriIEPuPw+q1THp8 nima.kalantar@focusrite.com"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILp007s4hFGCvBDiBwDzY45KZfyjUEcE34nE5W2eYPGD nima.kalantar@focusrite.com"
      ];
      extraGroups = ["networkmanager" "wheel" "docker"];
    };
  };
}
