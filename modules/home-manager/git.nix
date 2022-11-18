{ config, pkgs, ... }:

let
  gitConfig = {
    core = {
      editor = "nano";
    };
    init.defaultBranch = "main";
    pull.rebase = true;
    push.autoSetupRemote = true;
    url = {
      "https://github.com/".insteadOf = "gh:";
      "ssh://git@github.com".pushInsteadOf = "gh:";
      "https://gitlab.com/".insteadOf = "gl:";
      "ssh://git@gitlab.com".pushInsteadOf = "gl:";
    };
    commit.gpgsign = true;
    gpg.format = "ssh";
    gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    user.signingKey = "~/.ssh/id_ed25519.pub";
  };
in
{
  home.file.".ssh/allowed_signers".text =  "* ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILp007s4hFGCvBDiBwDzY45KZfyjUEcE34nE5W2eYPGD";

  programs.git = {
    enable = true;
    extraConfig = gitConfig;
    lfs.enable = true;
    ignores = [
      "*.DS_Store"
    ];
    userName = "Nima Kalantar";
    userEmail = "nima.kalantar@focusrite.com";
  };
}
