# NixOS config

To deploy remotely:
```
deploy
```

To rebuild NixOS config:
```
sudo nixos-rebuild switch --flake .#nuc
```

To rebuild home-manager config:
```
home-manager switch --flake .#user@nuc
```

### TODO:
- Secrets management (sops-nix)
- Use BTRFS for /root
- Opt-in persistance (/tmpfs RAM disk)

Template from:
 - https://github.com/Misterio77/nix-starter-configs