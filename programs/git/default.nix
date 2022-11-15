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
    user.signingKey = "~/.ssh/github_ed25519.pub";
  };
in
{
  home.packages = with pkgs; [ git ];

  home.file.".ssh/allowed_signers".text =
    "* ${builtins.readFile /home/user/.ssh/github_ed25519.pub}";

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
