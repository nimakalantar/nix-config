# NixOS config

```
sudo nixos-rebuild switch --flake .#nuc
```

```
home-manager switch --flake .#user@nuc
```

### TODO:
- Secrets management (sops-nix)
- Deployment config (nixus or deploy-rs)
- Use BTRFS for /root
- Opt-in persistance (/tmpfs RAM disk)

Template from:
 - https://github.com/Misterio77/nix-starter-configs