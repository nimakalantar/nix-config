# NixOS config

```
sudo nixos-rebuild switch --flake .#nuc
```

```
home-manager switch --flake .#user@nuc
```

---

### TODO:
- Secrets management
- Use BTRFS for /
- Opt-in persistance (/tmpfs RAM disk)