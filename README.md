# NixOS config

To deploy remotely:
```
deploy -s
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
- [x] Pre-commit formatting (alejandra)
- [x] flake.lock update mechanism (renovate)
- [x] Managed deployments (deploy-rs)
- [ ] Secrets management (sops-nix)
- [ ] Use BTRFS for /root
- [ ] Opt-in persistance (/tmpfs RAM disk)
- [ ] Custom media

Template from:
 - https://github.com/Misterio77/nix-starter-configs