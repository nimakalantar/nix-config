{config, ...}: {
  environment.persistence."/nix/persist/system" = {
    directories = [
      "/etc/nixos"
      "/var/log"
      "/home"
    ];
    files = [
      "/etc/machine-id"
      "/etc/nix/id_ed25519"
      "/etc/nix/id_ed25519.pub"
    ];
  };
}
