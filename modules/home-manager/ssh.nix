{
  config,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "nuc" = {
        user = "user";
      };
      "nuc.lan" = {
        hostname = "192.168.1.121";
        user = "user";
      };
      "*.github.com" = {
        user = "git";
      };
    };
    extraConfig = "AddKeysToAgent yes";
  };
}
