# NixOS config

To deploy remotely:
```
deploy -s
```

To rebuild Darwin config:
```
nix build --extra-experimental-features nix-command --extra-experimental-features flakes .#FF0523
```

To rebuild NixOS config:
```
sudo nixos-rebuild switch --flake .#nuc
```

To rebuild home-manager config:
```
home-manager switch --flake .#user@nuc
```

To edit secrets:
```
sops secrets/hosts/nuc.yaml
```


### TODO:
- [x] Pre-commit formatting (alejandra)
- [x] flake.lock update mechanism (renovate)
- [x] Managed deployments (deploy-rs)
- [x] Secrets management (sops-nix)
- [x] Darwin configuration (nix-darwin)
- [ ] Use BTRFS for /root
- [ ] Opt-in persistance (/tmpfs RAM disk)
- [ ] Custom media

Template from:
 - https://github.com/Misterio77/nix-starter-configs