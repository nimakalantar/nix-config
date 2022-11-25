{config, ...}: {
  sops.defaultSopsFile = ../secrets/hosts/nuc.yaml;
  sops.age.sshKeyPaths = ["/etc/ssh/id_ed25519"];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;
}
