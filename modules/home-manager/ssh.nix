{ config, pkgs, ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*.github.com" = {
        identityFile = "~/.ssh/github_ed25519.pub";
      };
    };
    extraConfig = "AddKeysToAgent yes";
  };
}
