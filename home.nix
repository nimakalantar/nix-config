{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = (import ./programs);

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "user";
  home.homeDirectory = "/home/user";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    code-server
    docker
    circleci-cli
    pre-commit
  ];

  home.file.".ssh/allowed_signers".text =
    "* ${builtins.readFile /home/user/.ssh/github_ed25519.pub}";

  programs = {
    ssh = {
      enable = true;
      matchBlocks = {
	"*.github.com" = {
          identityFile = "~/.ssh/github_ed25519.pub";
        };
      };
      extraConfig = "UseKeychain yes\nAddKeysToAgent yes";
    };
  };
}
