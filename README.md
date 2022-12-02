# NixOS config

To deploy remotely:
```
deploy -s
```

## Darwin

To rebuild Darwin config:
```
darwin-rebuild switch --flake .
```

To rebuild home-manager config:
```
home-manager switch --flake .#nima.kalantar@FF0523
```

To edit secrets:
```
sops secrets/hosts/mac.yaml
```

## NixOS

To build ISO:
```
sudo nix build .#nixosConfigurations.nucIso.config.system.build.isoImage
```

To rebuild NixOS config:
```
sudo nixos-rebuild switch --flake .#nuc
```

To rebuild home-manager config:
```
sudo home-manager switch --flake .#user@nuc
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
- [x] Custom media
- [x] Disk configuration (disko)
- [ ] Opt-in persistance (/tmpfs RAM disk)
- [ ] Semi-secret management (import git-crypted config)

Template from:
 - https://github.com/Misterio77/nix-starter-configs