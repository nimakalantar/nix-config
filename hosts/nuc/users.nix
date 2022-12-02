{config, ...}: {
  sops.secrets = {
    "root_pass".neededForUsers = true;
    "user_pass".neededForUsers = true;
  };

  users = {
    mutableUsers = false;
    users = {
      root = {
        passwordFile = config.sops.secrets.root_pass.path;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKqN6QIStiPMRYSQZsLVmhEtQrOToriIEPuPw+q1THp8"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILp007s4hFGCvBDiBwDzY45KZfyjUEcE34nE5W2eYPGD"
        ];
      };
      user = {
        passwordFile = config.sops.secrets.user_pass.path;
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKqN6QIStiPMRYSQZsLVmhEtQrOToriIEPuPw+q1THp8"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILp007s4hFGCvBDiBwDzY45KZfyjUEcE34nE5W2eYPGD"
        ];
        extraGroups = ["wheel" "docker"];
      };
    };
  };
}
